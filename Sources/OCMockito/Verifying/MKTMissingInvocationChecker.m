// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTMissingInvocationChecker.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"
#import "MKTLocation.h"
#import "MKTMatchingInvocationsFinder.h"
#import "MKTPrinter.h"


@implementation MKTMissingInvocationChecker

- (instancetype)init
{
    self = [super initWithWantedDescription:@"Missing"];
    return self;
}

- (nullable NSString *)checkInvocations:(NSArray<MKTInvocation *> *)invocations wanted:(MKTInvocationMatcher *)wanted
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    NSString *description;
    if (self.invocationsFinder.count == 0)
    {
        MKTInvocation *similar = MKTFindSimilarInvocation(invocations, wanted);
        if (similar)
            description = [self argumentsAreDifferent:similar wanted:wanted];
        else
            description = [self wantedButNotInvoked:wanted otherInvocations:invocations];
    }
    return description;
}

- (NSString *)argumentsAreDifferent:(MKTInvocation *)actual wanted:(MKTInvocationMatcher *)wanted
{
    MKTPrinter *printer = [[MKTPrinter alloc] init];
    NSArray<NSString *> *description = @[
            @"Argument(s) are different!",
            [@"Wanted: " stringByAppendingString:[printer printMatcher:wanted]],
            @"Actual invocation has different arguments:",
            [printer printInvocation:actual],
            [printer printMismatchOf:actual expectation:wanted],
            @"",
            actual.location.description,
    ];
    return [description componentsJoinedByString:@"\n"];
}

- (NSString *)wantedButNotInvoked:(MKTInvocationMatcher *)wanted
                 otherInvocations:(NSArray<MKTInvocation *> *)invocations
{
    MKTPrinter *printer = [[MKTPrinter alloc] init];
    NSMutableArray<NSString *> *description = [@[
            @"Wanted but not invoked:",
            [printer printMatcher:wanted],
    ] mutableCopy];

    if (!invocations.count)
        [description addObject:@"Actually, there were zero interactions with this mock."];
    else
        [self reportOtherInvocations:invocations toDescriptionArray:description];

    return [description componentsJoinedByString:@"\n"];
}

- (void)reportOtherInvocations:(NSArray<MKTInvocation *> *)invocations
            toDescriptionArray:(NSMutableArray<NSString *> *)description
{
    MKTPrinter *printer = [[MKTPrinter alloc] init];
    [description addObject:@"However, there were other interactions with this mock (✓ means already verified):"];
    for (MKTInvocation *invocation in invocations)
    {
        [description addObject:@""];
        [description addObject:[printer printInvocation:invocation]];
        [description addObject:invocation.location.description];
    }
}

@end


MKTInvocation *MKTFindSimilarInvocation(NSArray<MKTInvocation *> *invocations, MKTInvocationMatcher *wanted)
{
    NSUInteger index = [invocations indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        MKTInvocation *inv = obj;
        return !inv.verified && inv.invocation.selector == wanted.expected.selector;
    }];
    return (index == NSNotFound) ? nil : invocations[index];
}
