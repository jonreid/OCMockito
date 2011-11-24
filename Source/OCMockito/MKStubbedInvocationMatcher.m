//
//  OCMockito - MKStubbedInvocationMatcher.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKStubbedInvocationMatcher.h"


@implementation MKStubbedInvocationMatcher

@synthesize answer;

- (void)dealloc
{
    [answer release];
    [super dealloc];
}

@end
