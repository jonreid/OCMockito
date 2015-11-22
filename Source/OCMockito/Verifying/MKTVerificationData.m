//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTVerificationData.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTInvocation.h"


@implementation MKTVerificationData

- (instancetype)initWithInvocationContainer:(MKTInvocationContainer *)invocations
                          invocationMatcher:(MKTInvocationMatcher *)wanted;
{
    self = [super init];
    if (self)
    {
        _invocations = invocations;
        _wanted = wanted;
    }
    return self;
}

- (NSUInteger)numberOfMatchingInvocations
{
    NSUInteger count = 0;
    for (MKTInvocation *invocation in self.invocations.registeredInvocations)
    {
        if ([self.wanted matches:invocation.invocation])
            ++count;
    }
    return count;
}

@end
