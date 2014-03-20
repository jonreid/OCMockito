//
//  OCMockito - MKTUnsignedShortArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedShortArgumentGetter.h"

@implementation MKTUnsignedShortArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(unsigned short)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    unsigned short arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
