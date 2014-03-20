//
//  OCMockito - MKTUnsignedCharReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedCharReturnTypeSetter.h"


@implementation MKTUnsignedCharReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(unsigned char)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    unsigned char value = [returnValue unsignedCharValue];
    [invocation setReturnValue:&value];
}

@end
