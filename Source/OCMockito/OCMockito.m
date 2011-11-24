//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MKExactTimes.h"
#import "MKMockitoCore.h"
#import "MKTestLocation.h"


MKOngoingStubbing *MKGivenWithLocation(id methodCall, id testCase, const char *fileName, int lineNumber)
{
    return MKGivenPreviousCallWithLocation(testCase, fileName, lineNumber);
}

MKOngoingStubbing *MKGivenPreviousCallWithLocation(id testCase, const char *fileName, int lineNumber)
{
    MKMockitoCore *mockitoCore = [MKMockitoCore sharedCore];
    return [mockitoCore stubAtLocation:MKTestLocationMake(testCase, fileName, lineNumber)];
}

id MKVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    return MKVerifyCountWithLocation(mock, MKTimes(1), testCase, fileName, lineNumber);
}

id MKVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber)
{
    MKMockitoCore *mockitoCore = [MKMockitoCore sharedCore];
    return [mockitoCore verifyMock:mock
                          withMode:mode
                        atLocation:MKTestLocationMake(testCase, fileName, lineNumber)];
}

id MKTimes(NSUInteger wantedNumberOfInvocations)
{
    return [MKExactTimes timesWithCount:wantedNumberOfInvocations];
}

id MKNever()
{
    return MKTimes(0);
}
