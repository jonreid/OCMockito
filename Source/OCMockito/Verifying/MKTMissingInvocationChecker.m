//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"
#import "MKTMatchingInvocationsFinder.h"
#import "MKTInvocationMatcher.h"
#import "MKTInvocation.h"


static MKTInvocation *MKTFindSimilarInvocation(NSArray *invocations, MKTInvocationMatcher *wanted)
{
    NSUInteger index = [invocations indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        MKTInvocation *inv = obj;
        return inv.invocation.selector == wanted.expected.selector;
    }];
    return (index == NSNotFound) ? nil : invocations[index];
}


@implementation MKTMissingInvocationChecker

- (MKTInvocation *(^)(NSArray *, MKTInvocationMatcher *))findSimilarInvocation
{
    if (!_findSimilarInvocation)
    {
        _findSimilarInvocation = ^MKTInvocation *(NSArray *invocations, MKTInvocationMatcher *wanted) {
            return MKTFindSimilarInvocation(invocations, wanted);
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
