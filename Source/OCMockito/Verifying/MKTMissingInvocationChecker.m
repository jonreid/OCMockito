//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"
#import "MKTMatchingInvocationsFinder.h"
#import "MKTPrinter.h"


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
    NSString *description;
    if (self.invocationsFinder.count == 0)
    {
        MKTInvocation *similar = self.findSimilarInvocation(invocations, wanted);
        if (similar)
            description = [self argumentsAreDifferent:similar wanted:wanted];
    }
    return description;
}

- (NSString *)argumentsAreDifferent:(MKTInvocation *)actual wanted:(MKTInvocationMatcher *)wanted
{
    MKTPrinter *printer = [[MKTPrinter alloc] init];
    NSArray *description = @[
            @"Argument(s) are different!",
            [@"Wanted: " stringByAppendingString:[printer printMatcher:wanted]],
            @"Actual invocation has different arguments:",
            [printer printInvocation:actual],
            [printer printMismatchOf:actual expectation:wanted],
            @"Call stack:",
            actual.location.description,
    ];
    return [description componentsJoinedByString:@"\n"];
}

@end
