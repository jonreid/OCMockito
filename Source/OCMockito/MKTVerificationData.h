//
//  OCMockito - MKTVerificationData.h
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTInvocationContainer;
@class MKTInvocationMatcher;


@interface MKTVerificationData : NSObject

@property (nonatomic, strong, readonly) MKTInvocationContainer *invocations;
@property (nonatomic, strong, readonly) MKTInvocationMatcher *wanted;
@property (nonatomic, assign, readonly) MKTTestLocation testLocation;

- (id)initWithInvocations:(MKTInvocationContainer *)invocations
                   wanted:(MKTInvocationMatcher *)wanted
             testLocation:(MKTTestLocation)testLocation;

@end
