//
//  OCMockito - MTMockingProgress.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockingProgress.h"

#import "MTVerificationMode.h"


@interface MTMockingProgress ()
@property(nonatomic, retain) MTOngoingStubbing *ongoingStubbing;
@property(nonatomic, retain) id <MTVerificationMode> verificationMode;
@end


@implementation MTMockingProgress

@synthesize testLocation;
@synthesize ongoingStubbing;
@synthesize verificationMode;


+ (id)sharedProgress
{
    static id sharedProgress = nil;
    
    if (!sharedProgress)
        sharedProgress = [[self alloc] init];
    return sharedProgress;
}


- (void)stubbingStartedAtLocation:(MTTestLocation)location
{
    [self setTestLocation:location];
}


- (void)reportOngoingStubbing:(MTOngoingStubbing *)theOngoingStubbing
{
    [self setOngoingStubbing:theOngoingStubbing];
}


- (MTOngoingStubbing *)pullOngoingStubbing
{
    MTOngoingStubbing *result = [ongoingStubbing retain];
    [self setOngoingStubbing:nil];
    return [result autorelease];
}


- (void)verificationStarted:(id <MTVerificationMode>)mode atLocation:(MTTestLocation)location
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
