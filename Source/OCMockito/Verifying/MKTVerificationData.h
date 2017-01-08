//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTInvocation;
@class MKTInvocationContainer;
@class MKTInvocationMatcher;


NS_ASSUME_NONNULL_BEGIN

@interface MKTVerificationData : NSObject

@property (nonatomic, copy, readonly) NSArray<MKTInvocation *> *invocations;
@property (nonatomic, strong, readonly) MKTInvocationMatcher *wanted;

- (instancetype)initWithInvocationContainer:(MKTInvocationContainer *)invocationContainer
                          invocationMatcher:(MKTInvocationMatcher *)wanted NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
