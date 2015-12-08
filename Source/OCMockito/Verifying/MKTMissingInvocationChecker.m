//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"
#import "MKTMatchingInvocationsFinder.h"
#import "MKTInvocationMatcher.h"


@implementation MKTMissingInvocationChecker

- (MKTInvocation *(^)(NSArray *, MKTInvocationMatcher *))findSimilarInvocation
{
    if (!_findSimilarInvocation)
    {
        _findSimilarInvocation = ^MKTInvocation *(NSArray *array, MKTInvocationMatcher *matcher) {
            return nil;
        };
    }
    return _findSimilarInvocation;
}

- (NSString *)checkInvocations:(NSArray *)invocations wanted:(MKTInvocationMatcher *)wanted
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    return nil;
}

@end
