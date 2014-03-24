//
//  OCMockito - MKTDoubleArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTDoubleArgumentGetter.h"

@implementation MKTDoubleArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(double)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    double arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
