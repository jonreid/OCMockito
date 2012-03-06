//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MKTExactTimes.h"
#import "MKTMockitoCore.h"
#import "MKTTestLocation.h"


MKTOngoingStubbing *MKTGivenWithLocation(id testCase, const char *fileName, int lineNumber, ...)
{
    MKTMockitoCore *mockitoCore = [MKTMockitoCore sharedCore];
    return [mockitoCore stubAtLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

id MKTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    if (!mock)
    {
        MKTTestLocation location = MKTTestLocationMake(testCase, fileName, lineNumber);
        MKTFailTestLocation(location, @"Argument passed to verify() should be a mock but is nil.");
        return nil;
    }
    
    return MKTVerifyCountWithLocation(mock, MKTTimes(1), testCase, fileName, lineNumber);
}

id MKTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber)
{
    if (!mock)
    {
        MKTTestLocation location = MKTTestLocationMake(testCase, fileName, lineNumber);
        MKTFailTestLocation(location, @"Argument passed to verifyCount() should be a mock but is nil.");
        return nil;
    }
    
    MKTMockitoCore *mockitoCore = [MKTMockitoCore sharedCore];
    return [mockitoCore verifyMock:mock
                          withMode:mode
                        atLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

id MKTTimes(NSUInteger wantedNumberOfInvocations)
{
    return [MKTExactTimes timesWithCount:wantedNumberOfInvocations];
}

id MKTNever()
{
    return MKTTimes(0);
}
