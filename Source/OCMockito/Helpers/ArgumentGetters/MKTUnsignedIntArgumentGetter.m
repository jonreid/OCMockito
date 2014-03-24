//
//  OCMockito - MKTUnsignedIntArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedIntArgumentGetter.h"

@implementation MKTUnsignedIntArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(unsigned int)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    unsigned int arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
