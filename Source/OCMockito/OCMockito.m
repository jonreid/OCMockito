//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MTExactTimes.h"
#import "MTMockitoCore.h"
#import "MTTestLocation.h"


MTOngoingStubbing *MTGivenWithLocation(id methodCall, id testCase, const char *fileName, int lineNumber)
{
    return MTGivenPreviousCallWithLocation(testCase, fileName, lineNumber);
}

MTOngoingStubbing *MTGivenPreviousCallWithLocation(id testCase, const char *fileName, int lineNumber)
{
    MTMockitoCore *mockitoCore = [MTMockitoCore sharedCore];
    return [mockitoCore stubAtLocation:MTTestLocationMake(testCase, fileName, lineNumber)];
}

id MTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    return MTVerifyCountWithLocation(mock, MTTimes(1), testCase, fileName, lineNumber);
}

id MTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber)
{
    MTMockitoCore *mockitoCore = [MTMockitoCore sharedCore];
    return [mockitoCore verifyMock:mock
                          withMode:mode
                        atLocation:MTTestLocationMake(testCase, fileName, lineNumber)];
}

id MTTimes(NSUInteger wantedNumberOfInvocations)
{
    return [MTExactTimes timesWithCount:wantedNumberOfInvocations];
}

id MTNever()
{
    return MTTimes(0);
}
