//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationMatcher.h"


@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher

- (void)addAnswer:(id)answer;
- (id)answer;

@end
