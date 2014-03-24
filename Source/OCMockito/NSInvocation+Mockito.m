//
//  OCMockito - NSInvocation+Mockito.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "NSInvocation+Mockito.h"

#import "MKTReturnSetter.h"
#import "MKTReturnSetterChain.h"
#import "MKTArgumentGetter.h"
#import "MKTArgumentGetterChain.h"


@implementation NSInvocation (Mockito)

- (NSArray *)mkt_arrayArguments     // Inspired by NSInvocation+TKAdditions by Taras Kalapun
{
    MKTArgumentGetter *chain = MKTArgumentGetterChain();
    NSMethodSignature *signature = self.methodSignature;
    NSUInteger numberOfArguments = [signature numberOfArguments];
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:numberOfArguments-2];

    for (NSUInteger idx = 2; idx < numberOfArguments; ++idx) // self and _cmd are at index 0 and 1
    {
        const char *argType = [signature getArgumentTypeAtIndex:idx];
        id arg = [chain retrieveArgumentAtIndex:idx ofType:argType onInvocation:self];
        if (arg)
            [args addObject:arg];
        else
            NSCAssert1(NO, @"-- Unhandled type: %s", argType);
    }

    return args;
}

- (void)mkt_setReturnValue:(id)returnValue
{
    MKTReturnSetter *chain = MKTReturnSetterChain();
    char const *returnType = [[self methodSignature] methodReturnType];
    [chain setReturnValue:returnValue ofType:returnType onInvocation:self];
}

@end
