//
//  OCMockito - MKVerificationData.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKVerificationData.h"


@implementation MKVerificationData

@synthesize invocations;
@synthesize wanted;
@synthesize testLocation;

- (void)dealloc
{
    [invocations release];
    [wanted release];
    [super dealloc];
}

@end
