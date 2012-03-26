//
//  OCMockito - MKTStubbedInvocationMatcher.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTStubbedInvocationMatcher.h"


@implementation MKTStubbedInvocationMatcher

@synthesize answer = _answer;

- (void)dealloc
{
    [_answer release];
    [super dealloc];
}

@end
