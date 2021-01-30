//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

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
