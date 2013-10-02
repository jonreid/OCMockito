//
//  OCMockito - MKTExactTimes.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTExactTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTTestLocation.h"
#import "MKTVerificationData.h"


@implementation MKTExactTimes
{
    NSUInteger expectedCount;
}

- (instancetype)initWithCount:(NSUInteger)expectedNumberOfInvocations
{
    self = [super init];
    if (self)
        expectedCount = expectedNumberOfInvocations;
    return self;
}


#pragma mark MKTVerificationMode

- (void)verifyData:(MKTVerificationData *)data
{
    NSUInteger matchingCount = 0;
    for (NSInvocation *invocation in data.invocations.registeredInvocations)
    {
        if ([data.wanted matches:invocation])
            ++matchingCount;
    }
    
    if (matchingCount != expectedCount)
    {
        NSString *plural = (expectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                 (unsigned)expectedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation(data.testLocation, description);
    }
}

@end
