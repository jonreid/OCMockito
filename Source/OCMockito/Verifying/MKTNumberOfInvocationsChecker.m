//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTNumberOfInvocationsChecker.h"

#import "MKTFilterCallStack.h"
#import "MKTInvocationMatcher.h"
#import "MKTInvocationsFinder.h"
#import "MKTParseCallStack.h"


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
    if (wantedCount > actualCount)
        description = [self tooLittleActual:actualCount wantedCount:wantedCount];
    else if (wantedCount == 0 && actualCount > 0)
        description = [self neverWantedButActual:actualCount];
    else if (wantedCount < actualCount)
        description = [self tooManyActual:actualCount wantedCount:wantedCount];
    return description;
}

- (NSString *)tooLittleActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount
{
    NSString *problem = [self describeWanted:wantedCount butWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfLastInvocation];
    return [self joinProblem:problem callStack:callStack label:@"Last invocation:"];
}

- (NSString *)neverWantedButActual:(NSUInteger)actualCount
{
    NSString *problem = [self describeNeverWantedButWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfInvocationAtIndex:0];
    return [self joinProblem:problem callStack:callStack label:@"Undesired invocation:"];
}

- (NSString *)tooManyActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount
{
    NSString *problem = [self describeWanted:wantedCount butWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfInvocationAtIndex:wantedCount];
    return [self joinProblem:problem callStack:callStack label:@"Undesired invocation:"];
}

- (NSString *)joinProblem:(NSString *)problem callStack:(NSArray *)callStack label:(NSString *)label
{
    if (!callStack)
        return problem;
    else
        return [problem stringByAppendingString:[self reportCallStack:callStack label:label]];
}

- (NSString *)describeWanted:(NSUInteger)wantedCount butWasCalled:(NSUInteger)actualCount
{
    return [NSString stringWithFormat:@"Wanted %@ but was called %@.",
                                      [self pluralizeTimes:wantedCount],
                                      [self pluralizeTimes:actualCount]];
}

- (NSString *)describeNeverWantedButWasCalled:(NSUInteger)actualCount
{
    return [NSString stringWithFormat:@"Never wanted but was called %@.",
                                      [self pluralizeTimes:actualCount]];
}

- (NSString *)pluralizeTimes:(NSUInteger)count
{
    return count == 1 ? @"1 time" : [NSString stringWithFormat:@"%lu times", (unsigned long)count];
}

- (NSString *)reportCallStack:(NSArray *)callStack label:(NSString *)label
{
    NSArray *stack = MKTFilterCallStack(MKTParseCallStack(callStack));
    return [NSString stringWithFormat:@" %@\n%@", label, [stack componentsJoinedByString:@"\n"]];
}

@end
