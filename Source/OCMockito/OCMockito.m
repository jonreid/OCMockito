//
//  OCMockito - OCMockito.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "OCMockito.h"

#import "MKTAtLeastTimes.h"
#import "MKTExactTimes.h"
#import "MKTMockitoCore.h"


static BOOL isValidMockClass(id mock)
{
    NSString *className = NSStringFromClass([mock class]);
    return [className isEqualToString:@"MKTObjectMock"] ||
            [className isEqualToString:@"MKTProtocolMock"] ||
            [className isEqualToString:@"MKTClassObjectMock"] ||
            [className isEqualToString:@"MKTObjectAndProtocolMock"];
}

static NSString *actualTypeName(id mock)
{
    NSString *className = NSStringFromClass([mock class]);
    if (className)
        return [@"type " stringByAppendingString:className];
    else
        return @"nil";
}

static BOOL reportedInvalidMock(id mock, id testCase, const char *fileName, int lineNumber, NSString *functionName)
{
    if (isValidMockClass(mock))
        return NO;
    NSString *description = [NSString stringWithFormat:@"Argument passed to %@ should be a mock but is %@",
                                                       functionName, actualTypeName(mock)];
    MKTFailTest(testCase, fileName, lineNumber, description);
    return YES;
}

MKTOngoingStubbing *MKTGivenWithLocation(id testCase, const char *fileName, int lineNumber, ...)
{
    return [[MKTMockitoCore sharedCore] stubAtLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

id MKTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidMock(mock, testCase, fileName, lineNumber, @"verify()"))
        return nil;
    
    return MKTVerifyCountWithLocation(mock, MKTTimes(1), testCase, fileName, lineNumber);
}

id MKTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber)
{
    if (reportedInvalidMock(mock, testCase, fileName, lineNumber, @"verifyCount()"))
        return nil;

    return [[MKTMockitoCore sharedCore] verifyMock:mock
                                          withMode:mode
                                        atLocation:MKTTestLocationMake(testCase, fileName, lineNumber)];
}

id MKTTimes(NSUInteger wantedNumberOfInvocations)
{
    return [MKTExactTimes timesWithCount:wantedNumberOfInvocations eventually:NO];
}

id MKTEventuallyTimes(NSUInteger wantedNumberOfInvocations)
{
    return [MKTExactTimes timesWithCount:wantedNumberOfInvocations eventually:YES];
}

id MKTNever()
{
    return MKTTimes(0);
}

id MKTEventuallyNever()
{
    return MKTEventuallyTimes(0);
}

id MKTAtLeast(NSUInteger minimumWantedNumberOfInvocations)
{
    return [MKTAtLeastTimes timesWithMinimumCount:minimumWantedNumberOfInvocations eventually:NO];
}

id MKTEventuallyAtLeast(NSUInteger minimumWantedNumberOfInvocations)
{
    return [MKTAtLeastTimes timesWithMinimumCount:minimumWantedNumberOfInvocations eventually:YES];
}

id MKTAtLeastOnce()
{
    return MKTAtLeast(1);
}

id MKTEventuallyAtLeastOnce()
{
    return MKTEventuallyAtLeast(1);
}



static NSTimeInterval sEventuallyDefaultTimeout = 1.0; // seconds

NSTimeInterval MKT_eventuallyDefaultTimeout()
{
    return sEventuallyDefaultTimeout;
}

void MKT_setEventuallyDefaultTimeout(NSTimeInterval defaultTimeout)
{
    sEventuallyDefaultTimeout = defaultTimeout;
}
