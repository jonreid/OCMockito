//
//  OCMockito - NSInvocation+OCMockito.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "NSInvocation+OCMockito.h"

#import "MKTArgumentGetter.h"
#import "MKTArgumentGetterChain.h"
#import "MKTReturnValueSetter.h"
#import "MKTReturnValueSetterChain.h"


@implementation NSInvocation (OCMockito)

- (NSArray *)mkt_arrayArguments     // Inspired by NSInvocation+TKAdditions by Taras Kalapun
{
    NSMethodSignature *signature = self.methodSignature;
    NSUInteger numberOfArguments = [signature numberOfArguments];
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:numberOfArguments-2];

    for (NSUInteger idx = 2; idx < numberOfArguments; ++idx) // self and _cmd are at index 0 and 1
    {
        const char *argType = [signature getArgumentTypeAtIndex:idx];
        id arg = [MKTArgumentGetterChain() retrieveArgumentAtIndex:idx ofType:argType onInvocation:self];
        if (arg)
            [args addObject:arg];
        else
            NSCAssert1(NO, @"-- Unhandled type: %s", argType);
    }

    return args;
}

- (void)mkt_setReturnValue:(id)returnValue
{
    char const *returnType = [[self methodSignature] methodReturnType];
    [MKTReturnValueSetterChain() setReturnValue:returnValue ofType:returnType onInvocation:self];
}

@end
