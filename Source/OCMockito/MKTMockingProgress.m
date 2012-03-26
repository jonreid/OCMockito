//
//  OCMockito - MKTMockingProgress.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTMockingProgress.h"

#import "MKTInvocationMatcher.h"
#import "MKTVerificationMode.h"


@interface MKTMockingProgress ()
@property (nonatomic, retain) MKTInvocationMatcher *invocationMatcher;
@property (nonatomic, retain) id <MKTVerificationMode> verificationMode;
@property (nonatomic, retain) MKTOngoingStubbing *ongoingStubbing;
@end


@implementation MKTMockingProgress

@synthesize testLocation = _testLocation;
@synthesize invocationMatcher = _invocationMatcher;
@synthesize verificationMode = _verificationMode;
@synthesize ongoingStubbing = _ongoingStubbing;

+ (id)sharedProgress
{
    static id sharedProgress = nil;
    
    if (!sharedProgress)
        sharedProgress = [[self alloc] init];
    return sharedProgress;
}

- (void)dealloc
{
    [_invocationMatcher release];
    [_verificationMode release];
    [_ongoingStubbing release];
    [super dealloc];
}

- (void)stubbingStartedAtLocation:(MKTTestLocation)location
{
    [self setTestLocation:location];
}

- (void)reportOngoingStubbing:(MKTOngoingStubbing *)ongoingStubbing
{
    [self setOngoingStubbing:ongoingStubbing];
}

- (MKTOngoingStubbing *)pullOngoingStubbing
{
    MKTOngoingStubbing *result = [_ongoingStubbing retain];
    [self setOngoingStubbing:nil];
    return [result autorelease];
}

- (void)verificationStarted:(id <MKTVerificationMode>)mode atLocation:(MKTTestLocation)location
{
    [self setVerificationMode:mode];
    [self setTestLocation:location];
}

- (id <MKTVerificationMode>)pullVerificationMode
{
    id <MKTVerificationMode> result = [_verificationMode retain];
    [self setVerificationMode:nil];
    return [result autorelease];
}

- (void)setMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    if (!_invocationMatcher)
        _invocationMatcher = [[MKTInvocationMatcher alloc] init];
    [_invocationMatcher setMatcher:matcher atIndex:index+2];
}

- (MKTInvocationMatcher *)pullInvocationMatcher
{
    MKTInvocationMatcher *result = [_invocationMatcher retain];
    [self setInvocationMatcher:nil];
    return [result autorelease];
}

@end
