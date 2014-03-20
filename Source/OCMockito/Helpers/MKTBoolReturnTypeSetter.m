//
//  OCMockito - MKTBoolReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTBoolReturnTypeSetter.h"


@implementation MKTBoolReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(BOOL)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    BOOL value = [returnValue boolValue];
    [invocation setReturnValue:&value];
}

@end
