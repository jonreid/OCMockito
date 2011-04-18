//
//  OCMockito - MTInvocationMatcher.h
//  Copyright 2011 eBay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HCMatcher;


@interface MTInvocationMatcher : NSObject

- (void)setMatcher:(id <HCMatcher>)matcher forIndex:(NSUInteger)index;

- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation;
- (BOOL)matches:(NSInvocation *)actual;

@end
