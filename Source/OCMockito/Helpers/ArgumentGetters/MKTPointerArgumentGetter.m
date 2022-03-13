// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTPointerArgumentGetter.h"


@implementation MKTPointerArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(void *) successor:successor];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    void *arg;
    [invocation getArgument:&arg atIndex:idx];
    return [NSValue valueWithPointer:arg];
}

@end
