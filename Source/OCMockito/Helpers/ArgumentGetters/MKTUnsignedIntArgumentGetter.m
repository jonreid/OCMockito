// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTUnsignedIntArgumentGetter.h"

@implementation MKTUnsignedIntArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(unsigned int) successor:successor];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    unsigned int arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
