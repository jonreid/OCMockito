//
//  OCMockito - MKTMockingProgress.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MKTestLocation.h"

@class MKTInvocationMatcher;
@class MKTOngoingStubbing;
@protocol HCMatcher;
@protocol MKVerificationMode;


@interface MKTMockingProgress : NSObject

@property(nonatomic, assign) MKTestLocation testLocation;

+ (id)sharedProgress;

- (void)stubbingStartedAtLocation:(MKTestLocation)location;
- (void)reportOngoingStubbing:(MKTOngoingStubbing *)theOngoingStubbing;
- (MKTOngoingStubbing *)pullOngoingStubbing;

- (void)setMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;
- (MKTInvocationMatcher *)pullInvocationMatcher;

- (void)verificationStarted:(id <MKVerificationMode>)mode atLocation:(MKTestLocation)location;
- (id <MKVerificationMode>)pullVerificationMode;

@end
