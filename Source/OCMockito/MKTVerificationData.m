//
//  OCMockito - MKTVerificationData.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTVerificationData.h"


@implementation MKTVerificationData

@synthesize invocations = _invocations;
@synthesize wanted = _wanted;
@synthesize testLocation = _testLocation;

- (void)dealloc
{
    [_invocations release];
    [_wanted release];
    [super dealloc];
}

@end
