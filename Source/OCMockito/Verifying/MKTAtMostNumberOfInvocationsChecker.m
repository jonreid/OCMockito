// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTAtMostNumberOfInvocationsChecker.h"

#import "MKTMatchingInvocationsFinder.h"


@implementation MKTAtMostNumberOfInvocationsChecker

- (instancetype)init
{
    self = [super initWithWantedDescription:@"Wanted at most"];
    return self;
}

- (nullable NSString *)checkInvocations:(NSArray<MKTInvocation *> *)invocations
                                 wanted:(MKTInvocationMatcher *)wanted
                            wantedCount:(NSUInteger)wantedCount
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    NSUInteger actualCount = self.invocationsFinder.count;
    NSString *description;
    if (wantedCount == 0 && actualCount > 0)
        description = [self neverWantedButActual:actualCount];
    else if (wantedCount < actualCount)
        description = [self tooManyActual:actualCount wantedCount:wantedCount];
    return description;
}

@end
