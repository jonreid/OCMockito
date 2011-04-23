//
//  OCMockito - MTOngoingStubbing.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTInvocationContainer;
@protocol HCMatcher;


@interface MTOngoingStubbing : NSObject

- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer;
- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;
- (id)withMatcher:(id <HCMatcher>)matcher;
- (MTOngoingStubbing *)willReturn:(id)object;

@end
