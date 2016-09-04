//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart
//  Contribution by Igor Sales

#import "MKTClassObjectMock.h"

#import "MKTSwizzler.h"


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
        _swizzler.classMock = self;
    }
    return self;
}

- (void)dealloc
{
    [self unswizzleSingletons];
}

- (void)mkt_stopMocking
{
    [self unswizzleSingletons];
    [super mkt_stopMocking];
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
    [self.swizzler swizzleSingletonAtSelector:singletonSelector];
}

- (void)unswizzleSingletons
{
    [self.swizzler unswizzleSingletonsForMock];
    self.swizzler.classMock = nil;
}

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mockedClass respondsToSelector:aSelector];
}

@end
