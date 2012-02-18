//
//  OCMockito - MKTMockitoCore.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTMockitoCore.h"

#import "MKTMockingProgress.h"
#import "MKVerificationMode.h"


@interface MKTMockitoCore ()
@property(nonatomic, retain) MKTMockingProgress *mockingProgress;
- (MKOngoingStubbing *)stub;
@end


@implementation MKTMockitoCore

@synthesize mockingProgress;

+ (id)sharedCore
{
    static id sharedCore = nil;

    if (!sharedCore)
        sharedCore = [[self alloc] init];
    return sharedCore;
}

- (id)init
{
    self = [super init];
    if (self)
        mockingProgress = [[MKTMockingProgress sharedProgress] retain];
    return self;
}

- (void)dealloc
{
    [mockingProgress release];
    [super dealloc];
}

- (MKOngoingStubbing *)stubAtLocation:(MKTestLocation)location
{
    [mockingProgress stubbingStartedAtLocation:location];
    return [self stub];
}

- (MKOngoingStubbing *)stub
{
    return [mockingProgress pullOngoingStubbing];
}

- (id)verifyMock:(MKTClassMock *)mock
        withMode:(id <MKVerificationMode>)mode
      atLocation:(MKTestLocation)location
{
    [mockingProgress verificationStarted:mode atLocation:location];
    return mock;
}

@end
