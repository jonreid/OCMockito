//
//  OCMockito - MKInvocationContainer.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MKMockingProgress;
@protocol HCMatcher;


@interface MKInvocationContainer : NSObject

@property(nonatomic, retain) NSMutableArray *registeredInvocations;

- (id)initWithMockingProgress:(MKMockingProgress *)theMockingProgress;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (void)addAnswer:(id)answer;
- (id)findAnswerFor:(NSInvocation *)invocation;

@end
