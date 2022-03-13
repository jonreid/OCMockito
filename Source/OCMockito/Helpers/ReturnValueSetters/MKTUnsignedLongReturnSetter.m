// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTUnsignedLongReturnSetter.h"


@implementation MKTUnsignedLongReturnSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor
{
    self = [super initWithType:@encode(unsigned long) successor:successor];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    unsigned long value = [returnValue unsignedLongValue];
    [invocation setReturnValue:&value];
}

@end
