// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTMockitoCore.h"

#import "MKTMockingProgress.h"
#import "MKTVerificationMode.h"
#import "MKTObjectMock.h"

@interface MKTMockitoCore ()
@property (nonatomic, strong, readonly) MKTMockingProgress *mockingProgress;
@end

@implementation MKTMockitoCore

+ (instancetype)sharedCore
{
    static id sharedCore = nil;
    if (!sharedCore)
        sharedCore = [[self alloc] init];
    return sharedCore;
}

- (instancetype)init
{
    self = [super init];
    if (self)
        _mockingProgress = [MKTMockingProgress sharedProgress];
    return self;
}

- (MKTOngoingStubbing *)stubAtLocation:(MKTTestLocation)location
{
    [self.mockingProgress stubbingStartedAtLocation:location];
    return [self stub];
}

- (MKTOngoingStubbing *)stub
{
    return [self.mockingProgress pullOngoingStubbing];
}

- (id)verifyMock:(MKTObjectMock *)mock
        withMode:(id <MKTVerificationMode>)mode
      atLocation:(MKTTestLocation)location
{
    [self.mockingProgress verificationStarted:mode atLocation:location withMock:mock];
    return mock;
}

@end
