//
//  OCMockito - MKInvocationMatcher.h
//  Copyright 2011 eBay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HCMatcher;


@interface MKInvocationMatcher : NSObject

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex;
- (NSUInteger)argumentMatchersCount;

- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation;
- (BOOL)matches:(NSInvocation *)actual;

@end
