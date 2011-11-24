//
//  OCMockito - MKStubbedInvocationMatcher.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKInvocationMatcher.h"


@interface MKStubbedInvocationMatcher : MKInvocationMatcher

@property(nonatomic, retain) id answer;

@end
