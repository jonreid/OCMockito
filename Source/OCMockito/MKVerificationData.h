//
//  OCMockito - MKVerificationData.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTInvocationContainer;
@class MKTInvocationMatcher;


@interface MKVerificationData : NSObject

@property(nonatomic, retain) MKTInvocationContainer *invocations;
@property(nonatomic, retain) MKTInvocationMatcher *wanted;
@property(nonatomic, assign) MKTTestLocation testLocation;

@end
