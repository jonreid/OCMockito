//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import "MKTStructReturnSetter.h"


@implementation MKTStructReturnSetter

- (instancetype)initWithSuccessor:(nullable MKTReturnValueSetter *)successor
{
    self = [super initWithType:"{" successor:successor];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    NSMethodSignature *methodSignature = [invocation methodSignature];
    NSMutableData *value = [NSMutableData dataWithLength:[methodSignature methodReturnLength]];
    [returnValue getValue:[value mutableBytes]];
    [invocation setReturnValue:[value mutableBytes]];
}

@end
