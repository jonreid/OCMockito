//
//  OCMockito - MKTStubbedInvocationMatcher.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTStubbedInvocationMatcher.h"


@implementation MKTStubbedInvocationMatcher

- (void)dealloc
{
    [_answer release];
    [super dealloc];
}

@end
