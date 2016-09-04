//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart
//  Contribution by Igor Sales

#import "MKTClassObjectMock.h"

#import "MKTSwizzler.h"
#import <objc/runtime.h>


@implementation MKTClassObjectMock

+ (id)mockSingleton
{
    MKTClassObjectMockMapEntry *entry = singletonMap[singletonKey(self, _cmd)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [entry.mock performSelector:_cmd withObject:nil];
#pragma clang diagnostic pop
}

- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
    {
        _mockedClass = aClass;
        _swizzler = [[MKTSwizzler alloc] init];
    }
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

- (void)swizzleSingletonAtSelector:(SEL)singletonSelector
{
    [self.swizzler swizzleSingletonAtSelector:singletonSelector toMock:self];
}

- (void)unswizzleSingletonFromEntry:(MKTClassObjectMockMapEntry *)swizzle
{
    NSAssert(swizzle, @"Invalid argument. swizzle argument cannot be nil");
    Method origMethod = class_getClassMethod(swizzle.mockedClass, swizzle.selector);
    method_setImplementation(origMethod, swizzle.oldIMP);
}

- (void)unswizzleSingletons
{
    NSMutableArray *keysToRemove = [[NSMutableArray alloc] init];

    [singletonMap enumerateKeysAndObjectsUsingBlock:^(NSString *key,
            MKTClassObjectMockMapEntry *swizzle,
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

    [singletonMap removeObjectsForKeys:keysToRemove];
}

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mockedClass respondsToSelector:aSelector];
}

@end
