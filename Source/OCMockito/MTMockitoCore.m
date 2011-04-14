//
//  OCMockito - MTMockitoCore.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockitoCore.h"

#import "MTMockingProgress.h"
#import "MTVerificationMode.h"


@interface MTMockitoCore ()
- (MTOngoingStubbing *)stub;
@end


@implementation MTMockitoCore

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
        mockingProgress = [[MTMockingProgress alloc] init];
    return self;
}


- (void)dealloc
{
    [mockingProgress release];
    [super dealloc];
}


- (MTOngoingStubbing *)givenAtLocation:(MTTestLocation)location
{
    [mockingProgress stubbingStartedAtLocation:location];
    return [self stub];
}


- (MTOngoingStubbing *)stub
{
    return [mockingProgress pullOngoingStubbing];
}


- (id)verifyMock:(MTClassMock *)mock
        withMode:(id <MTVerificationMode>)mode
      atLocation:(MTTestLocation)location
{
    [mockingProgress verificationStarted:mode atLocation:location];
    return mock;
}

@end
