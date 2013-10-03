//
//  OCMockito - MKTStubbedInvocationMatcher.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTInvocationMatcher.h"
#import "MKTStubbedInvocationMatcher.h"


@implementation MKTStubbedInvocationMatcher

- (instancetype)initCopyingInvocationMatcher:(MKTInvocationMatcher *)other
{
    self = [super init];
    if (self)
    {
        self.expected = other.expected;
        self.numberOfArguments = other.numberOfArguments;
        self.argumentMatchers = [other.argumentMatchers mutableCopy];
    }
    return self;
}

@end
