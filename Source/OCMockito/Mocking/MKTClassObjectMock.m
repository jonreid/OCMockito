//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart

#import "MKTClassObjectMock.h"

#import "MKTSingletonSwizzler.h"


@interface MKTClassObjectMock ()
@property (nonatomic, strong) MKTSingletonSwizzler *swizzler;
@end

@implementation MKTClassObjectMock

- (instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self)
        _mockedClass = aClass;
    return self;
}

- (MKTSingletonSwizzler *)swizzler
{
    if (!_swizzler)
        _swizzler = [[MKTSingletonSwizzler alloc] initWithMock:self];
    return _swizzler;
}

- (void)mkt_stopMocking
{
    if (_swizzler)
    {
        [_swizzler unswizzleSingletonsForMock]; // Explicitly call for 32-bit iOS because dealloc is called too late.
        _swizzler = nil;
    }
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

#pragma mark NSObject protocol

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [self.mockedClass respondsToSelector:aSelector];
}

@end
