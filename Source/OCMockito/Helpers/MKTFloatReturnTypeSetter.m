//
//  OCMockito - MKTFloatReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTFloatReturnTypeSetter.h"


@implementation MKTFloatReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(float)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    float value = [returnValue floatValue];
    [invocation setReturnValue:&value];
}

@end
