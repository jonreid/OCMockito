// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MockTestCase.h"


@implementation MockTestCase

- (void)failWithException:(NSException *)exception
{
    ++_failureCount;
    [self setFailureException:exception];
}

- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected
{
    self.failureCount += 1;
    self.failureDescription = description;
}

@end
