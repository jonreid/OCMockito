//
//  OCMockito - MockTestCase.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MockTestCase.h"


@implementation MockTestCase

@synthesize failureCount = _failureCount;
@synthesize failureException = _failureException;

- (void)dealloc
{
    [_failureException release];
    [super dealloc];
}

- (void)failWithException:(NSException *)exception
{
    ++_failureCount;
    [self setFailureException:exception];
}

@end
