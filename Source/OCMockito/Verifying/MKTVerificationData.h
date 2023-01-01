// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

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
