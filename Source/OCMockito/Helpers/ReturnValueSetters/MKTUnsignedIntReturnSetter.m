//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTUnsignedIntReturnSetter.h"


@implementation MKTUnsignedIntReturnSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor
{
    self = [super initWithType:@encode(unsigned int) successor:successor];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    unsigned int value = [returnValue unsignedIntValue];
    [invocation setReturnValue:&value];
}

@end
