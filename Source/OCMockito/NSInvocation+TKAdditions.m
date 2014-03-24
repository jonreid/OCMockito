//
//  NSInvocation+TKAdditions.m
//
//  Created by Taras Kalapun
//

#import "NSInvocation+TKAdditions.h"

#import "MKTReturnSetter.h"
#import "MKTReturnSetterChain.h"
#import "MKTArgumentGetter.h"
#import "MKTArgumentGetterChain.h"


@implementation NSInvocation (TKAdditions)

- (NSArray *)tk_arrayArguments
{
    NSMethodSignature *sig = self.methodSignature;
    NSUInteger numberOfArguments = [sig numberOfArguments];
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:numberOfArguments-2];
    MKTArgumentGetter *chain = MKTArgumentGetterChain();

    for (NSUInteger idx = 2; idx < numberOfArguments; ++idx) // self and _cmd are at index 0 and 1
    {
        const char *argType = [sig getArgumentTypeAtIndex:idx];
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
