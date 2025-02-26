// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTAtLeastNumberOfInvocationsChecker.h"

#import "MKTMatchingInvocationsFinder.h"


@implementation MKTAtLeastNumberOfInvocationsChecker

- (instancetype)init
{
    self = [super initWithWantedDescription:@"Wanted at least"];
    return self;
}

- (nullable NSString *)checkInvocations:(NSArray<MKTInvocation *> *)invocations
                                 wanted:(MKTInvocationMatcher *)wanted
                            wantedCount:(NSUInteger)wantedCount
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    NSUInteger actualCount = self.invocationsFinder.count;
    NSString *description;
    if (wantedCount > actualCount)
        description = [self tooLittleActual:actualCount wantedCount:wantedCount];
    return description;
}

@end
