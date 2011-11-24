//
//  OCMockito - MKMockitoCore.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKMockitoCore.h"

#import "MKMockingProgress.h"
#import "MKVerificationMode.h"


@interface MKMockitoCore ()
@property(nonatomic, retain) MKMockingProgress *mockingProgress;
- (MKOngoingStubbing *)stub;
@end


@implementation MKMockitoCore

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
        mockingProgress = [[MKMockingProgress sharedProgress] retain];
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

- (id)verifyMock:(MKClassMock *)mock
        withMode:(id <MKVerificationMode>)mode
      atLocation:(MKTestLocation)location
{
    [mockingProgress verificationStarted:mode atLocation:location];
    return mock;
}

@end
