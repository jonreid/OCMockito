//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2022 Jonathan M. Reid. See LICENSE.txt

#import "MKTMockingProgress.h"

#import "MKTInvocationMatcher.h"
#import "MKTOngoingStubbing.h"
#import "MKTVerificationMode.h"
#import "MKTBaseMockObject.h"

@interface MKTMockingProgress ()
@property (nonatomic, assign, readwrite) MKTTestLocation testLocation;
@property (nonatomic, strong) MKTInvocationMatcher *invocationMatcher;
@property (nonatomic, strong) id <MKTVerificationMode> verificationMode;
@property (nonatomic, strong) MKTBaseMockObject *verificationModeMockObject;

@property (nonatomic, strong) MKTOngoingStubbing *ongoingStubbing;
@end

@implementation MKTMockingProgress

+ (instancetype)sharedProgress
{
    static id sharedProgress = nil;
    if (!sharedProgress)
        sharedProgress = [[self alloc] init];
    return sharedProgress;
}

- (void)reset
{
    self.invocationMatcher = nil;
    self.verificationMode = nil;
    self.ongoingStubbing = nil;
}

- (void)stubbingStartedAtLocation:(MKTTestLocation)location
{
    [self setTestLocation:location];
}

- (void)reportOngoingStubbing:(MKTOngoingStubbing *)ongoingStubbing
{
    self.ongoingStubbing = ongoingStubbing;
}

- (MKTOngoingStubbing *)pullOngoingStubbing
{
    MKTOngoingStubbing *result = self.ongoingStubbing;
    self.ongoingStubbing = nil;
    return result;
}

- (void)verificationStarted:(id <MKTVerificationMode>)mode atLocation:(MKTTestLocation)location withMock:(MKTBaseMockObject *)mock
{
    self.verificationMode = mode;
    self.verificationModeMockObject = mock;
    [self setTestLocation:location];
}

- (id <MKTVerificationMode>)pullVerificationModeWithMock:(MKTBaseMockObject *)mock
{
    id <MKTVerificationMode> result = self.verificationMode;

    if ([mock isEqual:self.verificationModeMockObject])
        self.verificationMode = nil;

    return result;
}

- (void)setMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    if (!self.invocationMatcher)
        self.invocationMatcher = [[MKTInvocationMatcher alloc] init];
    [self.invocationMatcher setMatcher:matcher atIndex:index];
}

- (MKTInvocationMatcher *)pullInvocationMatcher
{
    MKTInvocationMatcher *result = self.invocationMatcher;
    self.invocationMatcher = nil;
    return result;
}

- (void)setOngoingStubbing:(MKTOngoingStubbing *)ongoingStubbing
{
    @synchronized (self)
    {
        _ongoingStubbing = ongoingStubbing;
    }
}

@end
