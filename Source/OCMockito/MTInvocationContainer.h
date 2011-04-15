//
//  OCMockito - MTInvocationContainer.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTMockingProgress;


@interface MTInvocationContainer : NSObject

@property(nonatomic, retain) NSMutableArray *registeredInvocations;
@property(nonatomic, retain) id answer;

- (id)initWithMockingProgress:(MTMockingProgress *)theMockingProgress;
- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation;
- (void)addAnswer:(id)object;

@end
