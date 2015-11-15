//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTInvocationContainer;
@class MKTInvocationMatcher;


@interface MKTVerificationData : NSObject

@property (nonatomic, strong, readonly) MKTInvocationContainer *invocations;
@property (nonatomic, strong, readonly) MKTInvocationMatcher *wanted;
@property (nonatomic, assign) MKTTestLocation testLocation;

- (instancetype)initWithInvocationContainer:(MKTInvocationContainer *)invocations
                          invocationMatcher:(MKTInvocationMatcher *)wanted;
- (NSUInteger)numberOfMatchingInvocations;

@end
