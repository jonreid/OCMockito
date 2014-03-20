//
//  OCMockito - MKTUnsignedLongArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedLongArgumentGetter.h"

@implementation MKTUnsignedLongArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(unsigned long)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    unsigned long arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
