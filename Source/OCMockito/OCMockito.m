//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MTClassMock.h"
#import "MTLineLocation.h"
#import "MTMockitoCore.h"
#import "MTTimes.h"


@implementation OCMockito

+ (id)mockForClass:(Class)aClass testCase:(id)test
{
    return [MTClassMock mockForClass:aClass testCase:test];
}

@end


id MTVerifyWithLocation(id mock, const char *fileName, int lineNumber)
{
    MTMockitoCore *mockitoCore = [MTMockitoCore sharedCore];
    return [mockitoCore verifyMock:mock
                          withMode:[MTTimes timesWithCount:1]
                        atLocation:MTLineLocationMake(fileName, lineNumber)];
}
