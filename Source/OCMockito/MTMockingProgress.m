//
//  OCMockito - MTMockingProgress.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockingProgress.h"

#import "MTVerificationMode.h"


@interface MTMockingProgress ()
@property(nonatomic, retain) id <MTVerificationMode> verificationMode;
@end


@implementation MTMockingProgress

@synthesize testLocation;
@synthesize verificationMode;


- (void)verification:(id <MTVerificationMode>)mode startedAtLocation:(MTTestLocation)location
{
    [self setVerificationMode:mode];
    [self setTestLocation:location];
}


- (id <MTVerificationMode>)pullVerificationMode
{
    id <MTVerificationMode> result = [verificationMode retain];
    [self setVerificationMode:nil];
    return [result autorelease];
}

@end
