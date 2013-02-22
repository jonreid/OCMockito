//
//  OCMockito - MKTVerificationData.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTInvocationContainer;
@class MKTInvocationMatcher;


@interface MKTVerificationData : NSObject

@property (strong, nonatomic) MKTInvocationContainer *invocations;
@property (strong, nonatomic) MKTInvocationMatcher *wanted;
@property (assign, nonatomic) MKTTestLocation testLocation;

@end
