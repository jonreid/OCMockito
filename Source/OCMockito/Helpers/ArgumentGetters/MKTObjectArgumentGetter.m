// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTObjectArgumentGetter.h"

@implementation MKTObjectArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(id) successor:successor];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    __unsafe_unretained id arg = nil;
    [invocation getArgument:&arg atIndex:idx];
    return arg ? arg : [NSNull null];
}

@end
