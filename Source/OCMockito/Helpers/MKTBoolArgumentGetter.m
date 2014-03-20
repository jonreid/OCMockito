//
//  OCMockito - MKTBoolArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTBoolArgumentGetter.h"

@implementation MKTBoolArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(BOOL)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    BOOL arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
