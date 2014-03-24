//
//  OCMockito - MKTIntArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTIntArgumentGetter.h"

@implementation MKTIntArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(int)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    int arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
