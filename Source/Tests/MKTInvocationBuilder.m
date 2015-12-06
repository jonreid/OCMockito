//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationBuilder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"


@interface MKTMethods : NSObject
@end

@implementation MKTMethods

- (void)simpleMethod {}
- (void)differentMethod {}

@end


@interface MKTInvocationBuilder ()
@property (nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) NSMethodSignature *signature;
@end

@implementation MKTInvocationBuilder

+ (instancetype)invocationBuilder
{
    MKTInvocationBuilder *builder = [[MKTInvocationBuilder alloc] init];
    [builder theSelector:@selector(simpleMethod)];  // Default if we don't care which method is invoked.
    return builder;
}

- (MKTInvocationBuilder *)simpleMethod
{
    return [self theSelector:@selector(simpleMethod)];
}

- (MKTInvocationBuilder *)differentMethod
{
    return [self theSelector:@selector(differentMethod)];
}

- (MKTInvocationBuilder *)theSelector:(SEL)selector
{
    self.aSelector = selector;
    self.signature = [[MKTMethods class] instanceMethodSignatureForSelector:selector];
    return self;
}

- (NSInvocation *)buildNSInvocation
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self.signature];
    [invocation setSelector:self.aSelector];
    return invocation;
}

- (MKTInvocation *)buildMKTInvocation
{
    NSInvocation *invocation = [self buildNSInvocation];
    return [[MKTInvocation alloc] initWithInvocation:invocation];
}

- (MKTInvocationMatcher *)buildInvocationMatcher
{
    NSInvocation *invocation = [self buildNSInvocation];
    MKTInvocationMatcher *matcher = [[MKTInvocationMatcher alloc] init];
    [matcher setExpectedInvocation:invocation];
    return matcher;
}

@end
