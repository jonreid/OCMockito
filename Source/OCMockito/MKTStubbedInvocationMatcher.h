//
//  OCMockito - MKTStubbedInvocationMatcher.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTInvocationMatcher.h"


@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher

@property (nonatomic, copy) id (^answer)(NSInvocation *invocation);

- (id)initCopyingInvocationMatcher:(MKTInvocationMatcher *)other;

@end
