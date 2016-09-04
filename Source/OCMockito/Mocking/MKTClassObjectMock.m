//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart
//  Contribution by Igor Sales

#import "MKTClassObjectMock.h"
#import <objc/runtime.h>


@interface MKTClassObjectMock ()
@property (nonatomic, strong, readonly) Class mockedClass;
@end

NSMutableDictionary *sSingletonMap = nil;

@interface _MKTClassObjectMockMapEntry : NSObject
{
@public
    __weak MKTClassObjectMock *_mock;
}

@property (nonatomic, weak, readonly) MKTClassObjectMock *mock;
@property (nonatomic, weak, readonly) Class mockedClass;
@property (nonatomic, assign, readonly) IMP oldIMP;
@property (nonatomic, assign, readonly) SEL selector;

@end

@implementation _MKTClassObjectMockMapEntry

- (instancetype)initWithMock:(MKTClassObjectMock *)mock IMP:(IMP)oldIMP selector:(SEL)selector
{
    self = [super init];
    if (self)
    {
        _mock = mock;
        _mockedClass = mock.mockedClass;
        _oldIMP = oldIMP;
        _selector = selector;
    }
    return self;
}

@end


@implementation MKTClassObjectMock

+ (void)initialize
{
    if (!sSingletonMap)
        sSingletonMap = [NSMutableDictionary new];
}

#define SINGLETON_KEY(C, S) [NSString stringWithFormat:@"%@-%@", C, NSStringFromSelector(S)]

+ (id)mockSingleton
{
    NSString *key = SINGLETON_KEY(self, _cmd);
    
    _MKTClassObjectMockMapEntry *entry = sSingletonMap[key];
    
    MKTClassObjectMock *mock = entry.mock;
    if (mock)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [mock performSelector:_cmd withObject:nil];
#pragma clang diagnostic pop
    }

    return nil;
}


- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
        _mockedClass = aClass;
    return self;
}

- (void)dealloc
{
    [self unswizzleSingletons];
}

- (NSString *)description
{
    return [@"mock class of " stringByAppendingString:NSStringFromClass(self.mockedClass)];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [self.mockedClass methodSignatureForSelector:aSelector];
}

#pragma mark Operations

- (void)swizzleSingletonAtSelector:(SEL)singletonSelector
{
    NSString *key = SINGLETON_KEY(_mockedClass, singletonSelector);

    Method origMethod = class_getClassMethod(_mockedClass, singletonSelector);
    Method newMethod = class_getClassMethod([self class], @selector(mockSingleton));

    IMP oldIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);

    method_setImplementation(origMethod, newIMP);

    _MKTClassObjectMockMapEntry *entry = sSingletonMap[key];
    if (entry)
    {
        // The user has already swizzled this singleton, keep the original implementation
        oldIMP = entry.oldIMP;
    }
    
    sSingletonMap[key] = [[_MKTClassObjectMockMapEntry alloc] initWithMock:self
                                                                       IMP:oldIMP
                                                                  selector:singletonSelector];
}

- (void)unswizzleSingletonAtSelector:(SEL)singletonSelector
{
    NSString *key = SINGLETON_KEY(_mockedClass, singletonSelector);
    _MKTClassObjectMockMapEntry *entry = sSingletonMap[key];
    if (!entry)
    {
        NSLog(@"Trying to unswizzle inexistent singleton method: + [%@ %@]",
                self.mockedClass,
                NSStringFromSelector(singletonSelector));
        return;
    }

    [self unswizzleSingletonFromEntry:entry];
}

#pragma mark - Private

- (void)unswizzleSingletonFromEntry:(_MKTClassObjectMockMapEntry *)swizzle
{
    NSAssert(swizzle, @"Invalid argument. swizzle argument cannot be nil");
    Method origMethod = class_getClassMethod(swizzle.mockedClass, swizzle.selector);
    method_setImplementation(origMethod, swizzle.oldIMP);
}

- (void)unswizzleSingletons
{
    NSMutableArray *keysToRemove = [NSMutableArray new];

    [sSingletonMap enumerateKeysAndObjectsUsingBlock:^(NSString *key,
            _MKTClassObjectMockMapEntry *swizzle,
            BOOL *stop) {
        
        //if (swizzle.mockedClass == self.mockedClass) {
        // At time of dealloc, it's possible the weak ref to swizzle.mock is nil,
        // so we also check directly on the struct member
        if (swizzle.mock == self || swizzle->_mock == self)
        {
            [self unswizzleSingletonFromEntry:swizzle];
            [keysToRemove addObject:key];
        }
    }];

    [sSingletonMap removeObjectsForKeys:keysToRemove];
}

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mockedClass respondsToSelector:aSelector];
}

@end
