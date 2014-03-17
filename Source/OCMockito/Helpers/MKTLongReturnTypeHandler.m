//
//  OCMockito - MKTLongReturnTypeHandler.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTLongReturnTypeHandler.h"


@implementation MKTLongReturnTypeHandler

- (instancetype)init
{
    self = [super initWithType:@encode(long)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    long value = [returnValue longValue];
    [invocation setReturnValue:&value];
}

@end
