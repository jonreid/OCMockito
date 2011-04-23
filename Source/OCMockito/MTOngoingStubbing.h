//
//  OCMockito - MTOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MTPrimitiveArgumentMatching.h"

@class MTInvocationContainer;


@interface MTOngoingStubbing : NSObject <MTPrimitiveArgumentMatching>

- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer;
- (MTOngoingStubbing *)willReturn:(id)object;

@end
