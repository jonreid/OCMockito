//
//  OCMockito - MTVerificationData.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTVerificationData.h"


@implementation MTVerificationData

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
