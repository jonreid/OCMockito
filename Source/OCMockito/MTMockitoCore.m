//
//  OCMockito - MTMockitoCore.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTMockitoCore.h"

#import "MTMockingProgress.h"
#import "MTVerificationMode.h"


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


- (id)verifyMock:(MTClassMock *)mock
        withMode:(id <MTVerificationMode>)mode
      atLocation:(MTLineLocation)location
{
    [mockingProgress verificationStarted:mode lineLocation:location];
    return mock;
}

@end
