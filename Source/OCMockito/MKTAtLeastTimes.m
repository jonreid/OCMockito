//
//  OCMockito - MKTAtLeastTimes.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by Markus Gasser on 18.04.12.
//

#import "MKTAtLeastTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTTestLocation.h"
#import "MKTVerificationData.h"
#import "NSException+OCMockito.h"


@interface MKTAtLeastTimes ()
{
    NSUInteger minimumExpectedCount;
}
@end


@implementation MKTAtLeastTimes

+ (id)timesWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations
{
    return [[[self alloc] initWithMinimumCount:minimumExpectedNumberOfInvocations] autorelease];
}

- (id)initWithMinimumCount:(NSUInteger)minimumExpectedNumberOfInvocations
{
    self = [super init];
    if (self)
        minimumExpectedCount = minimumExpectedNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    if (minimumExpectedCount == 0)
        return;     // this always succeeds
    
    NSUInteger matchingCount = 0;
    for (NSInvocation *invocation in [[data invocations] registeredInvocations])
    {
        if ([[data wanted] matches:invocation])
            ++matchingCount;
    }
    
    if (matchingCount < minimumExpectedCount)
    {
        NSString *plural = (minimumExpectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %d matching invocation%@, but received %d",
                                 minimumExpectedCount, plural, matchingCount];
        MKTFailTestLocation([data testLocation], description);
    }
}

@end
