//
//  OCMockito - MTVerificationData.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTTestLocation.h"

@class MTInvocationContainer;
@class MTInvocationMatcher;


@interface MTVerificationData : NSObject

@property(nonatomic, retain) MTInvocationContainer *invocations;
@property(nonatomic, retain) MTInvocationMatcher *wanted;
@property(nonatomic, assign) MTTestLocation testLocation;

@end
