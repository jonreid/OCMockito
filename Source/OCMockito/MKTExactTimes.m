//
//  OCMockito - MKTExactTimes.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTExactTimes.h"

#import "OCMockito.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTTestLocation.h"
#import "MKTVerificationData.h"


// As of 2010-09-09, the iPhone simulator has a bug where you can't catch exceptions when they are
// thrown across NSInvocation boundaries. (See http://openradar.appspot.com/8081169 ) So instead of
// using an NSInvocation to call -failWithException: without linking in SenTestingKit, we simply
// pretend it exists on NSObject.
@interface NSObject (MTExceptionBugHack)
- (void)failWithException:(NSException *)exception;
@end


@implementation MKTExactTimes
{
    NSUInteger _expectedCount;
    BOOL _eventually;
}

+ (id)timesWithCount:(NSUInteger)expectedNumberOfInvocations eventually:(BOOL)eventually
{
    return [[self alloc] initWithCount:expectedNumberOfInvocations eventually:eventually];
}

- (id)initWithCount:(NSUInteger)expectedNumberOfInvocations eventually:(BOOL)eventually
{
    self = [super init];
    if (self)
    {
        _expectedCount = expectedNumberOfInvocations;
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
    NSUInteger matchingCount;
    if (_eventually)
    {
        NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:MKT_eventuallyDefaultTimeout()];
        while (1)
        {
            matchingCount = [self matchingCountWithData:data];
            if (matchingCount > _expectedCount || [(NSDate *)[NSDate date] compare:expiryDate] == NSOrderedDescending)
                break;
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
        }
    }
    else
    {
        matchingCount = [self matchingCountWithData:data];
    }

    if (matchingCount != _expectedCount)
    {
        NSString *plural = (_expectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %u matching invocation%@, but received %u",
                                 (unsigned)_expectedCount, plural, (unsigned)matchingCount];
        MKTFailTestLocation([data testLocation], description);
    }
}

@end
