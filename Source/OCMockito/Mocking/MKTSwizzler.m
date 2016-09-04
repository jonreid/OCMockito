//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Igor Sales

#import "MKTSwizzler.h"

#import "MKTClassObjectMock.h"
#import <objc/runtime.h>


NSMutableDictionary *MKTSingletonMap = nil;

NSString *mkt_singletonKey(Class aClass, SEL aSelector)
{
    return [NSString stringWithFormat:@"%@-%@", aClass, NSStringFromSelector(aSelector)];
}


@implementation MKTSingletonMapEntry

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


@implementation MKTSwizzler

+ (void)initialize
{
    if (!MKTSingletonMap)
        MKTSingletonMap = [[NSMutableDictionary alloc] init];
}

+ (id)mockSingleton
{
    MKTSingletonMapEntry *singleton = MKTSingletonMap[mkt_singletonKey(self, _cmd)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [singleton.mock performSelector:_cmd withObject:nil];
#pragma clang diagnostic pop
}

- (void)dealloc
{
    [self unswizzleSingletonsForMock];
}

- (void)swizzleSingletonAtSelector:(SEL)singletonSelector
{
    MKTClassObjectMock *theMock = self.classMock;
    NSString *key = mkt_singletonKey(theMock.mockedClass, singletonSelector);
    
    Method origMethod = class_getClassMethod(theMock.mockedClass, singletonSelector);
    Method newMethod = class_getClassMethod([self class], @selector(mockSingleton));
    
    IMP oldIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);
    
    method_setImplementation(origMethod, newIMP);
    
    MKTSingletonMapEntry *entry = MKTSingletonMap[key];
    if (entry)
    {
        // The user has already swizzled this singleton, keep the original implementation
        oldIMP = entry.oldIMP;
    }
    
    MKTSingletonMap[key] = [[MKTSingletonMapEntry alloc] initWithMock:theMock
                                                                     IMP:oldIMP
                                                                selector:singletonSelector];
}

- (void)unswizzleSingletonsForMock
{
    MKTClassObjectMock *theMock = self.classMock;
    NSMutableArray *keysToRemove = [[NSMutableArray alloc] init];
    
    [MKTSingletonMap enumerateKeysAndObjectsUsingBlock:^(NSString *key,
            MKTSingletonMapEntry *swizzle,
            BOOL *stop) {
        
        //if (swizzle.mockedClass == self.mockedClass) {
        // At time of dealloc, it's possible the weak ref to swizzle.mock is nil,
        // so we also check directly on the struct member
        if (swizzle.mock == theMock || swizzle->_mock == theMock)
        {
            [self unswizzleSingletonFromEntry:swizzle];
            [keysToRemove addObject:key];
        }
    }];
    
    [MKTSingletonMap removeObjectsForKeys:keysToRemove];
}

- (void)unswizzleSingletonFromEntry:(MKTSingletonMapEntry *)swizzle
{
    Method origMethod = class_getClassMethod(swizzle.mockedClass, swizzle.selector);
    method_setImplementation(origMethod, swizzle.oldIMP);
}

@end
