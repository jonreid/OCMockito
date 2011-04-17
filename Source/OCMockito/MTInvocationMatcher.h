//
//  OCMockito - MTInvocationMatcher.h
//  Copyright 2011 eBay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MTInvocationMatcher : NSObject

- (id)initWithExpectedInvocation:(NSInvocation *)expected;
- (BOOL)matches:(NSInvocation *)actual;

@end
