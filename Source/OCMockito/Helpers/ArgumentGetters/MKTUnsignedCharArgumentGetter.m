//
//  OCMockito - MKTUnsignedCharArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedCharArgumentGetter.h"

@implementation MKTUnsignedCharArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(unsigned char)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    unsigned char arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
