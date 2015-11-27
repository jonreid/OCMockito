//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTNumberOfInvocationsChecker.h"

#import "MKTInvocationsFinder.h"
#import "MKTInvocationMatcher.h"
#import "MKTParseCallStack.h"
#import "MKTFilterCallStack.h"
#import "MKTCallStackElement.h"


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
    NSMutableString *description;
    if (wantedCount > actualCount)
    {
        description = [NSMutableString stringWithFormat:@"Wanted %@ but was called %@.",
                                                        pluralizeTimes(wantedCount),
                                                        pluralizeTimes(actualCount)];
        NSArray *callStack = [self.invocationsFinder callStackOfLastInvocation];
        if (callStack) {
            [description appendString:@" Last invocation:"];
            NSArray *filteredCallStack = MKTFilterCallStack(MKTParseCallStack(callStack));
            for (MKTCallStackElement *element in filteredCallStack) {
                [description appendFormat:@"\n%@", element];
            }
        }
    }
    else if (wantedCount < actualCount)
    {
        description = [NSMutableString stringWithFormat:@"Wanted %@ but was called %@.",
                                                        pluralizeTimes(wantedCount),
                                                        pluralizeTimes(actualCount)];
        NSArray *callStack = [self.invocationsFinder callStackOfInvocationAtIndex:wantedCount];
        if (callStack) {
            [description appendString:@" Undesired invocation:"];
            NSArray *filteredCallStack = MKTFilterCallStack(MKTParseCallStack(callStack));
            for (MKTCallStackElement *element in filteredCallStack) {
                [description appendFormat:@"\n%@", element];
            }
        }
    }
    return description;
}

@end
