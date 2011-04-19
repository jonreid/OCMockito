//
//  OCMockito - MTMockingProgress.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockingProgress.h"

#import "MTInvocationMatcher.h"
#import "MTVerificationMode.h"


@interface MTMockingProgress ()
@property(nonatomic, retain) MTInvocationMatcher *invocationMatcher;
@property(nonatomic, retain) id <MTVerificationMode> verificationMode;
@property(nonatomic, retain) MTOngoingStubbing *ongoingStubbing;
@end


@implementation MTMockingProgress

@synthesize testLocation;
@synthesize invocationMatcher;
@synthesize verificationMode;
@synthesize ongoingStubbing;


+ (id)sharedProgress
{
    static id sharedProgress = nil;
    
    if (!sharedProgress)
        sharedProgress = [[self alloc] init];
    return sharedProgress;
}


- (void)dealloc
{
    [invocationMatcher release];
    [verificationMode release];
    [ongoingStubbing release];
    [super dealloc];
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


- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    if (!invocationMatcher)
        invocationMatcher = [[MTInvocationMatcher alloc] init];
    [invocationMatcher setMatcher:matcher atIndex:argumentIndex];
}


- (MTInvocationMatcher *)pullInvocationMatcher
{
    MTInvocationMatcher *result = [invocationMatcher retain];
    [self setInvocationMatcher:nil];
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
