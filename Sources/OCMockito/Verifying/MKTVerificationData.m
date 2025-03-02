// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTVerificationData.h"

#import "MKTInvocationContainer.h"


@interface MKTVerificationData ()
@property (nonatomic, strong, readonly) MKTInvocationContainer *invocationContainer;
@end


@implementation MKTVerificationData

@dynamic invocations;

- (instancetype)initWithInvocationContainer:(MKTInvocationContainer *)invocationContainer
                          invocationMatcher:(MKTInvocationMatcher *)wanted
{
    self = [super init];
    if (self)
    {
        _invocationContainer = invocationContainer;
        _wanted = wanted;
    }
    return self;
}

- (NSArray<MKTInvocation *> *)invocations
{
    return self.invocationContainer.registeredInvocations;
}

@end
