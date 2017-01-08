//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import "MKTSingletonSwizzler.h"

#import "MKTClassObjectMock.h"
#import <objc/runtime.h>

@class MKTSingletonMapEntry;

static NSMutableDictionary<NSString *, MKTSingletonMapEntry *> *singletonMap = nil;

static NSString *singletonKey(Class aClass, SEL aSelector)
{
    return [NSString stringWithFormat:@"%@-%@", aClass, NSStringFromSelector(aSelector)];
}


@interface MKTSingletonMapEntry : NSObject
@property (nonatomic, weak, readonly) MKTClassObjectMock *mock;
@property (nonatomic, assign, readonly) void *mockPtr;
@property (nonatomic, weak, readonly) Class mockedClass;
@property (nonatomic, assign, readonly) IMP oldIMP;
@property (nonatomic, assign, readonly) SEL selector;
@end

@implementation MKTSingletonMapEntry

- (instancetype)initWithMock:(MKTClassObjectMock *)mock IMP:(IMP)oldIMP selector:(SEL)aSelector
{
    self = [super init];
    if (self)
    {
        _mock = mock;
        _mockPtr = (__bridge void *)mock;
        _mockedClass = mock.mockedClass;
        _oldIMP = oldIMP;
        _selector = aSelector;
    }
    return self;
}

- (BOOL)isForMockPtr:(void *)theMockPtr
{
    // We use the mockPtr as the tag to the mock, since the mock can be nullified
    // when dealloc is called. The ptr here works as a unique tag to the mock.
    return _mockPtr == theMockPtr;
}

- (void)unswizzleSingleton
{
    Method originalMethod = class_getClassMethod(self.mockedClass, self.selector);
    method_setImplementation(originalMethod, self.oldIMP);
}

@end


@interface MKTSingletonSwizzler ()
@property (nonatomic, weak) MKTClassObjectMock *classMock;
@property (nonatomic, assign) void *classMockPtr;
@end

@implementation MKTSingletonSwizzler

+ (void)initialize
{
    if (!singletonMap)
        singletonMap = [[NSMutableDictionary alloc] init];
}

+ (id)mockSingleton
{
    MKTSingletonMapEntry *singleton = singletonMap[singletonKey(self, _cmd)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [singleton.mock performSelector:_cmd withObject:nil];
#pragma clang diagnostic pop
}

- (instancetype)initWithMock:(MKTClassObjectMock *)classMock
{
    self = [super init];
    if (self)
    {
        _classMock = classMock;
        _classMockPtr = (__bridge void *)classMock;
    }
    return self;
}

- (void)dealloc
{
    [self unswizzleSingletonsForMock];
}

- (void)swizzleSingletonAtSelector:(SEL)singletonSelector
{
    MKTClassObjectMock *theMock = self.classMock;
    IMP oldIMP = [self swizzleSingleton:singletonSelector forMock:theMock];
    [self registerSingleton:singletonSelector forMock:theMock oldIMP:oldIMP];
}

- (IMP)swizzleSingleton:(SEL)singletonSelector forMock:(MKTClassObjectMock *)theMock
{
    Method oldMethod = class_getClassMethod(theMock.mockedClass, singletonSelector);
    Method newMethod = class_getClassMethod([self class], @selector(mockSingleton));
    IMP newIMP = method_getImplementation(newMethod);
    return method_setImplementation(oldMethod, newIMP);
}

- (void)registerSingleton:(SEL)singletonSelector
                  forMock:(MKTClassObjectMock *)theMock
                   oldIMP:(IMP)oldIMP
{
    NSString *key = singletonKey(theMock.mockedClass, singletonSelector);
    MKTSingletonMapEntry *existingSingleton = singletonMap[key];
    if (existingSingleton)
        oldIMP = existingSingleton.oldIMP;
    singletonMap[key] = [[MKTSingletonMapEntry alloc] initWithMock:theMock
                                                               IMP:oldIMP
                                                          selector:singletonSelector];
}

- (void)unswizzleSingletonsForMock
{
    void *theMockPtr = self.classMockPtr;
    NSMutableArray<NSString *> *keysToRemove = [[NSMutableArray alloc] init];
    
    [singletonMap enumerateKeysAndObjectsUsingBlock:^(NSString *key,
            MKTSingletonMapEntry *swizzled,
            BOOL *stop) {
        if ([swizzled isForMockPtr:theMockPtr])
        {
            [swizzled unswizzleSingleton];
            [keysToRemove addObject:key];
        }
    }];
    
    [singletonMap removeObjectsForKeys:keysToRemove];
}

@end
