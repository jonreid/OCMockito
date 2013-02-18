//
//  OCMockito - MKTVerificationData.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTVerificationData.h"
#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"


@implementation MKTVerificationData

- (id)initWithInvocations:(MKTInvocationContainer *)invocations
                   wanted:(MKTInvocationMatcher *)wanted
             testLocation:(MKTTestLocation)testLocation
{
    self = [super init];
    if (self)
    {
        _invocations = invocations;
        _wanted = wanted;
        _testLocation = testLocation;
    }
    return self;
}
@end
