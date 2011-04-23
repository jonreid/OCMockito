//
//  OCMockito - MTStubbedInvocationMatcher.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTStubbedInvocationMatcher.h"


@implementation MTStubbedInvocationMatcher

@synthesize answer;


- (void)dealloc
{
    [answer release];
    [super dealloc];
}

@end
