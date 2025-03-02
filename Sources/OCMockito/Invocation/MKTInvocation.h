// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@class MKTLocation;


NS_ASSUME_NONNULL_BEGIN

@interface MKTInvocation : NSObject

@property (nonatomic, strong, readonly) NSInvocation *invocation;
@property (nonatomic, strong, readonly) MKTLocation *location;
@property (nonatomic, assign) BOOL verified;

- (instancetype)initWithInvocation:(NSInvocation *)invocation;
- (instancetype)initWithInvocation:(NSInvocation *)invocation location:(MKTLocation *)location NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
