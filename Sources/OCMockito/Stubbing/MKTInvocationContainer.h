// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;
@class MKTStubbedInvocationMatcher;
@protocol HCMatcher;
@protocol MKTAnswer;


NS_ASSUME_NONNULL_BEGIN

@interface MKTInvocationContainer : NSObject

@property (nonatomic, copy, readonly) NSArray<MKTInvocation *> *registeredInvocations;

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (void)addAnswer:(id <MKTAnswer>)answer;
- (nullable MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation;
- (BOOL)isStubbingCopyMethod;

@end

NS_ASSUME_NONNULL_END
