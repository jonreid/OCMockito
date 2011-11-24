//
//  OCMockito - MKMockingProgress.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKMockingProgress.h"

#import "MKInvocationMatcher.h"
#import "MTVerificationMode.h"


@interface MKMockingProgress ()
@property(nonatomic, retain) MKInvocationMatcher *invocationMatcher;
@property(nonatomic, retain) id <MKVerificationMode> verificationMode;
@property(nonatomic, retain) MKOngoingStubbing *ongoingStubbing;
@end


@implementation MKMockingProgress

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

- (void)stubbingStartedAtLocation:(MKTestLocation)location
{
    [self setTestLocation:location];
}

- (void)reportOngoingStubbing:(MKOngoingStubbing *)theOngoingStubbing
{
    [self setOngoingStubbing:theOngoingStubbing];
}

- (MKOngoingStubbing *)pullOngoingStubbing
{
    MKOngoingStubbing *result = [ongoingStubbing retain];
    [self setOngoingStubbing:nil];
    return [result autorelease];
}

- (void)setMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    if (!invocationMatcher)
        invocationMatcher = [[MKInvocationMatcher alloc] init];
    [invocationMatcher setMatcher:matcher atIndex:index+2];
}

- (MKInvocationMatcher *)pullInvocationMatcher
{
    MKInvocationMatcher *result = [invocationMatcher retain];
    [self setInvocationMatcher:nil];
    return [result autorelease];
}

- (void)verificationStarted:(id <MKVerificationMode>)mode atLocation:(MKTestLocation)location
{
    [self setVerificationMode:mode];
    [self setTestLocation:location];
}

- (id <MKVerificationMode>)pullVerificationMode
{
    id <MKVerificationMode> result = [verificationMode retain];
    [self setVerificationMode:nil];
    return [result autorelease];
}

@end
