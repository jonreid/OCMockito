//
//  OCMockito - MKTIntReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTIntReturnTypeSetter.h"


@implementation MKTIntReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(int)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    int value = [returnValue intValue];
    [invocation setReturnValue:&value];
}

@end
