//
//  OCMockito - MKTShortReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTShortReturnTypeSetter.h"


@implementation MKTShortReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(short)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    short value = [returnValue shortValue];
    [invocation setReturnValue:&value];
}

@end
