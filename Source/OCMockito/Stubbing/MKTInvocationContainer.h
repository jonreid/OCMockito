//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocation;
@class MKTInvocationMatcher;
@class MKTStubbedInvocationMatcher;
@protocol HCMatcher;
@protocol MKTAnswer;


@interface MKTInvocationContainer : NSObject

@property (nonatomic, copy, readonly) NSArray<MKTInvocation *> *registeredInvocations;

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (void)addAnswer:(id <MKTAnswer>)answer;
- (MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation;
- (BOOL)isStubbingCopyMethod;

@end
