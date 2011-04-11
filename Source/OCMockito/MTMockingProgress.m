//
//  OCMockito - MTMockingProgress.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockingProgress.h"

#import "MTVerificationMode.h"


@interface MTMockingProgress ()
@property(nonatomic, retain) id <MTVerificationMode> verificationMode;
@property(nonatomic, assign) MTLineLocation lineLocation;
@end


@implementation MTMockingProgress

@synthesize verificationMode;
@synthesize lineLocation;


- (void)verificationStarted:(id <MTVerificationMode>)mode lineLocation:(MTLineLocation)location
{
    [self setVerificationMode:mode];
    [self setLineLocation:location];
}


- (id <MTVerificationMode>)pullVerificationMode
{
    id <MTVerificationMode> result = [verificationMode retain];
    [self setVerificationMode:nil];
    return [result autorelease];
}

@end
