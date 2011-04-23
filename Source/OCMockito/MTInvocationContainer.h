//
//  OCMockito - MTInvocationContainer.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTMockingProgress;


@interface MTInvocationContainer : NSObject

@property(nonatomic, retain) NSMutableArray *registeredInvocations;

- (id)initWithMockingProgress:(MTMockingProgress *)theMockingProgress;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)addAnswer:(id)answer;
- (id)findAnswerFor:(NSInvocation *)invocation;

@end
