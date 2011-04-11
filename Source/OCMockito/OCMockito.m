//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MTClassMock.h"


@implementation OCMockito

+ (id)mockForClass:(Class)aClass testCase:(id)test
{
    return [MTClassMock mockForClass:aClass testCase:test];
}

@end


id MTVerifyWithLocation(id mock, const char *fileName, int lineNumber)
{
    return nil;
}
