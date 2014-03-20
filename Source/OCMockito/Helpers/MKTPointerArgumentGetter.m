//
//  OCMockito - MKTPointerArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTPointerArgumentGetter.h"


@implementation MKTPointerArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(void *)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    void *arg;
    [invocation getArgument:&arg atIndex:idx];
    return [NSValue valueWithPointer:arg];
}

@end
