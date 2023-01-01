// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@protocol HCMatcher;


NS_ASSUME_NONNULL_BEGIN

@interface MKTInvocationMatcher : NSObject

@property (nonatomic, strong, readonly) NSInvocation *expected;
@property (nonatomic, assign, readonly) NSUInteger numberOfArguments;
@property (nonatomic, copy, readonly) NSArray<id <HCMatcher>> *matchers;

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)index;
- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation;
- (BOOL)matches:(NSInvocation *)actual;
- (void)stopArgumentCapture;
- (void)enumerateMismatchesOf:(NSInvocation *)actual
                   usingBlock:(void (^)(NSUInteger idx, NSString *description))block;

@end

NS_ASSUME_NONNULL_END
