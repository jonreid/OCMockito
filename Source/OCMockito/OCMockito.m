//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MTTestLocation.h"
#import "MTMockitoCore.h"
#import "MTTimes.h"


MTOngoingStubbing * MTGivenWithLocation(id methodCall, id testCase, const char *fileName, int lineNumber)
{
    MTMockitoCore *mockitoCore = [MTMockitoCore sharedCore];
    return [mockitoCore stubAtLocation:MTTestLocationMake(testCase, fileName, lineNumber)];
}


id MTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber)
{
    MTMockitoCore *mockitoCore = [MTMockitoCore sharedCore];
    return [mockitoCore verifyMock:mock
                          withMode:[MTTimes timesWithCount:1]
                        atLocation:MTTestLocationMake(testCase, fileName, lineNumber)];
}
