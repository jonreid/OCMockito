//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

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
- (MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation;
- (BOOL)isStubbingCopyMethod;

@end

NS_ASSUME_NONNULL_END
