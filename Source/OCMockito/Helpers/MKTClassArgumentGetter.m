//
//  OCMockito - MKTClassArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTClassArgumentGetter.h"

@implementation MKTClassArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(Class)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    __unsafe_unretained Class arg = nil;
    [invocation getArgument:&arg atIndex:idx];
    return arg;
}

@end
