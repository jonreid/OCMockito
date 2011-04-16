//
//  OCMockito - MTMockingProgress.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTTestLocation.h"

@class MTOngoingStubbing;
@protocol MTVerificationMode;


@interface MTMockingProgress : NSObject

@property(nonatomic, assign) MTTestLocation testLocation;

+ (id)sharedProgress;

- (void)stubbingStartedAtLocation:(MTTestLocation)location;
- (void)reportOngoingStubbing:(MTOngoingStubbing *)theOngoingStubbing;
- (MTOngoingStubbing *)pullOngoingStubbing;

- (void)verificationStarted:(id <MTVerificationMode>)mode atLocation:(MTTestLocation)location;
- (id <MTVerificationMode>)pullVerificationMode;

@end
