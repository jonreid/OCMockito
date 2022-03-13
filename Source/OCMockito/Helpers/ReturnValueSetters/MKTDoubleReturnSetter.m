// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTDoubleReturnSetter.h"


@implementation MKTDoubleReturnSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor
{
    self = [super initWithType:@encode(double) successor:successor];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    double value = [returnValue doubleValue];
    [invocation setReturnValue:&value];
}

@end
