//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTNumberOfInvocationsChecker.h"

#import "MKTInvocationsFinder.h"
#import "MKTInvocationMatcher.h"


static NSString *pluralizeTimes(NSUInteger count)
{
    return count == 1 ? @"1 time" : [NSString stringWithFormat:@"%d times", count];
}

@implementation MKTNumberOfInvocationsChecker

- (MKTInvocationsFinder *)invocationsFinder
{
    if (!_invocationsFinder) {
        _invocationsFinder = [[MKTInvocationsFinder alloc] init];
    }
    return _invocationsFinder;
}

- (NSString *)checkInvocations:(NSArray *)invocations
                        wanted:(MKTInvocationMatcher *)wanted
                   wantedCount:(NSUInteger)wantedCount
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    NSUInteger actualCount = self.invocationsFinder.count;
    NSString *description;
    if (wantedCount != actualCount)
    {
        description = [NSString stringWithFormat:@"Wanted %@ but was called %@",
                                                 pluralizeTimes(wantedCount),
                                                 pluralizeTimes(actualCount)];
    }
    return description;
}

@end
