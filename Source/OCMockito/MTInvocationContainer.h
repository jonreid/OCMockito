//
//  OCMockito - MTInvocationContainer.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTMockingProgress;
@protocol HCMatcher;


@interface MTInvocationContainer : NSObject

@property(nonatomic, retain) NSMutableArray *registeredInvocations;

- (id)initWithMockingProgress:(MTMockingProgress *)theMockingProgress;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (void)addAnswer:(id)answer;
- (id)findAnswerFor:(NSInvocation *)invocation;

@end
