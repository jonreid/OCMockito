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
- (void)methodWithArg:(id)arg {}

@end


@interface MKTInvocationBuilder ()
@property (nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) NSMethodSignature *signature;
@end

@implementation MKTInvocationBuilder

+ (instancetype)invocationBuilder
{
    MKTInvocationBuilder *builder = [[MKTInvocationBuilder alloc] init];
    [builder setSelector:@selector(simpleMethod)];  // Default if we don't care which method is invoked.
    return builder;
}

- (MKTInvocationBuilder *)simpleMethod
{
    [self setSelector:@selector(simpleMethod)];
    return self;
}

- (MKTInvocationBuilder *)differentMethod
{
    [self setSelector:@selector(differentMethod)];
    return self;
}

- (MKTInvocationBuilder *)methodWithArg:(__unsafe_unretained id)arg
{
    [self setSelector:@selector(methodWithArg:)];
    self.firstArgument = &arg;
    return self;
}

- (void)setSelector:(SEL)selector
{
    self.aSelector = selector;
    self.signature = [[MKTMethods class] instanceMethodSignatureForSelector:selector];
}

- (NSInvocation *)buildNSInvocation
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self.signature];
    [invocation setSelector:self.aSelector];
    if (self.firstArgument)
        [invocation setArgument:self.firstArgument atIndex:2];
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
