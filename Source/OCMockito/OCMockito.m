//
//  OCMockito - OCMockito.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "OCMockito.h"

#import "MTMockObject.h"


@implementation OCMockito

+ (id)mockForClass:(Class)aClass testCase:(id)test
{
    return [MTMockObject mockForClass:aClass testCase:test];
}

@end


id MTVerifyHappenedOnceWithLocation(id mock, const char *fileName, int lineNumber)
{
    return nil;
}
