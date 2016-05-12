//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart
//  Contribution by Igor Sales

#import "MKTClassObjectMock.h"
#import <objc/objc-runtime.h>


@interface MKTClassObjectMock ()
@property (nonatomic, strong, readonly) Class mockedClass;
@end

NSMutableDictionary* sSingletonMap = nil;

@interface _MKTClassObjectMockMapEntry : NSObject

@property (nonatomic, weak,   readonly) MKTClassObjectMock* mock;
@property (nonatomic, assign, readonly) IMP                 oldIMP;
@property (nonatomic, assign, readonly) SEL                 selector;

@end

@implementation _MKTClassObjectMockMapEntry

- (instancetype)initWithMock:(MKTClassObjectMock*)mock IMP:(IMP)oldIMP selector:(SEL)selector
{
    if (self = [super init]) {
        _mock     = mock;
        _oldIMP   = oldIMP;
        _selector = selector;
    }

    return self;
}

@end


@implementation MKTClassObjectMock


+ (void)initialize
{
    if (!sSingletonMap) {
        sSingletonMap = [NSMutableDictionary new];
    }
}

#define SINGLETON_KEY(C,S) [NSString stringWithFormat:@"%@-%@", C, NSStringFromSelector(S)]

+ (id)mockSingleton
{
    NSString* key = SINGLETON_KEY(self, _cmd);
    
    _MKTClassObjectMockMapEntry* entry = sSingletonMap[key];
    
    MKTClassObjectMock* mock = entry.mock;
    if (mock) {
        return [mock performSelector:_cmd withObject:nil];
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

- (void)dealloc {

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
    NSString* key = SINGLETON_KEY(_mockedClass, singletonSelector);
    
    if (sSingletonMap[key]) {
        NSLog(@"Trying to swizzle a singleton already swizzled.");
        return;
    }
    
    Method origMethod = class_getClassMethod(_mockedClass, singletonSelector);
    Method newMethod  = class_getClassMethod([self class], @selector(mockSingleton));

    IMP oldIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);

    if (oldIMP != newIMP) {
        method_setImplementation(origMethod, newIMP);

        sSingletonMap[key] = [[_MKTClassObjectMockMapEntry alloc] initWithMock:self
                                                                           IMP:oldIMP
                                                                      selector:singletonSelector];
    }
}

- (void)unswizzleSingletonAtSelector:(SEL)singletonSelector {

    NSString* key = SINGLETON_KEY(_mockedClass, singletonSelector);

    _MKTClassObjectMockMapEntry* entry = sSingletonMap[key];

    if (!entry) {
        NSLog(@"Trying to unswizzle inexistent singleton method: + [%@ %@]",
              self.mockedClass,
              NSStringFromSelector(singletonSelector));
        return;
    }

    [self unswizzleSingletonFromEntry:entry];
}

#pragma mark - Private

- (void)unswizzleSingletonFromEntry:(_MKTClassObjectMockMapEntry*)swizzle
{
    NSAssert(swizzle, @"Invalid argument. swizzle argument cannot be nil");

    Method origMethod = class_getClassMethod(_mockedClass, swizzle.selector);

    method_setImplementation(origMethod, swizzle.oldIMP);
}

- (void)unswizzleSingletons {

    NSMutableArray* keysToRemove = [NSMutableArray new];

    [sSingletonMap enumerateKeysAndObjectsUsingBlock:^(NSString* key,
                                                       _MKTClassObjectMockMapEntry* swizzle,
                                                       BOOL* stop) {
        if (swizzle.mock == self) {
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
