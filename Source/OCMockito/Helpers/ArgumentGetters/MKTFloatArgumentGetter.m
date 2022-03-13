// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTFloatArgumentGetter.h"

@implementation MKTFloatArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(float) successor:successor];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    float arg;
    [invocation getArgument:&arg atIndex:idx];
    return @(arg);
}

@end
