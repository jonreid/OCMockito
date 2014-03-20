//
//  OCMockito - MKTDoubleReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTDoubleReturnTypeSetter.h"


@implementation MKTDoubleReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(double)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    double value = [returnValue doubleValue];
    [invocation setReturnValue:&value];
}

@end
