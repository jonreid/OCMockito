//
//  OCMockito - MTStubbedInvocationMatcher.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationMatcher.h"


@interface MTStubbedInvocationMatcher : MTInvocationMatcher

@property(nonatomic, retain) id answer;

@end
