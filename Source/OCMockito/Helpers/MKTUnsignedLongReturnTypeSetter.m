//
//  OCMockito - MKTUnsignedLongReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedLongReturnTypeSetter.h"


@implementation MKTUnsignedLongReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(unsigned long)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    unsigned long value = [returnValue unsignedLongValue];
    [invocation setReturnValue:&value];
}

@end
