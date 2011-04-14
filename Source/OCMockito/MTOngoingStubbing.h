//
//  OCMockito - MTOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTInvocationContainer;


@interface MTOngoingStubbing : NSObject

- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer;
- (MTOngoingStubbing *)willReturn:(id)object;

@end
