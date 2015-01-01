//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocationMatcher;
@class MKTStubbedInvocationMatcher;
@protocol HCMatcher;
@protocol MKTExpectation;


@interface MKTInvocationContainer : NSObject

@property (readonly, nonatomic, strong) NSMutableArray *registeredInvocations;

- (instancetype)init;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (void)addAnswer:(id)answer;
- (void)addExpectation:(id<MKTExpectation>)expectation;
- (MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation;
@end
