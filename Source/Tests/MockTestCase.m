//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

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
