//
//  OCMockito - MKTUnsignedShortReturnSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTUnsignedShortReturnSetter.h"


@implementation MKTUnsignedShortReturnSetter

- (instancetype)init
{
    self = [super initWithType:@encode(unsigned short)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    unsigned short value = [returnValue unsignedShortValue];
    [invocation setReturnValue:&value];
}

@end
