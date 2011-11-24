//
//  OCMockito - MKMockingProgress.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MKTestLocation.h"

@class MKInvocationMatcher;
@class MKOngoingStubbing;
@protocol HCMatcher;
@protocol MKVerificationMode;


@interface MKMockingProgress : NSObject

@property(nonatomic, assign) MKTestLocation testLocation;

+ (id)sharedProgress;

- (void)stubbingStartedAtLocation:(MKTestLocation)location;
- (void)reportOngoingStubbing:(MKOngoingStubbing *)theOngoingStubbing;
- (MKOngoingStubbing *)pullOngoingStubbing;

- (void)setMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;
- (MKInvocationMatcher *)pullInvocationMatcher;

- (void)verificationStarted:(id <MKVerificationMode>)mode atLocation:(MKTestLocation)location;
- (id <MKVerificationMode>)pullVerificationMode;

@end
