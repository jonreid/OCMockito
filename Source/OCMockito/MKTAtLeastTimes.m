//
//  OCMockito - MKTAtLeastTimes.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Markus Gasser on 18.04.12.
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTAtLeastTimes.h"

#import "OCMockito.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTVerificationData.h"


@implementation MKTAtLeastTimes
{
    NSUInteger _minimumExpectedCount;
    BOOL _eventually;
}

+ (id)timesWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations eventually:(BOOL)eventually
{
    return [[self alloc] initWithMinimumCount:minimumExpectedNumberOfInvocations eventually:eventually];
}

- (id)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations eventually:(BOOL)eventually
{
    self = [super init];
    if (self)
    {
        _minimumExpectedCount = minimumExpectedNumberOfInvocations;
        _eventually = eventually;
    }
    return self;
}

- (NSUInteger)matchingCountWithData:(MKTVerificationData *)data
{
    NSUInteger matchingCount = 0;
    for (NSInvocation *invocation in [[data invocations] registeredInvocations])
    {
        if ([[data wanted] matches:invocation])
            ++matchingCount;
    }

    return matchingCount;
}

#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    if (_minimumExpectedCount == 0)
        return;     // this always succeeds

    NSUInteger matchingCount;
    if (_eventually)
    {
        NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:MKT_eventuallyDefaultTimeout()];
        while (1)
        {
            matchingCount = [self matchingCountWithData:data];
            if (matchingCount >= _minimumExpectedCount || [(NSDate *)[NSDate date] compare:expiryDate] == NSOrderedDescending)
                break;
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
        }
    }
    else
    {
        matchingCount = [self matchingCountWithData:data];
    }

    if (matchingCount < _minimumExpectedCount)
    {
        NSString *plural = (_minimumExpectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                 (unsigned)_minimumExpectedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation([data testLocation], description);
    }
}

@end
