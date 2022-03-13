// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTClassArgumentGetter.h"

@implementation MKTClassArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(Class) successor:successor];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    __unsafe_unretained Class arg = nil;
    [invocation getArgument:&arg atIndex:idx];
    return arg;
}

@end
