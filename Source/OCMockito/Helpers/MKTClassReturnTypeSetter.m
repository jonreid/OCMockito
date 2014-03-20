//
//  OCMockito - MKTClassReturnTypeSetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTClassReturnTypeSetter.h"


@implementation MKTClassReturnTypeSetter

- (instancetype)init
{
    self = [super initWithType:@encode(Class)];
    return self;
}

- (void)setReturnValue:(id)returnValue onInvocation:(NSInvocation *)invocation
{
    __unsafe_unretained Class value = returnValue;
    [invocation setReturnValue:&value];
}

@end
