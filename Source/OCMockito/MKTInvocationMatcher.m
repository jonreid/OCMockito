//
//  OCMockito - MKTInvocationMatcher.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTInvocationMatcher.h"

#import "MKTCapturingMatcher.h"
#import "NSInvocation+TKAdditions.h"

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
    #import <OCHamcrest/HCWrapInMatcher.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
    #import <OCHamcrestIOS/HCWrapInMatcher.h>
#endif


static inline BOOL typeEncodingIsObjectOrClass(const char *type)
{
    return *type == @encode(id)[0] || *type == @encode(Class)[0];
}


@implementation MKTInvocationMatcher

- (instancetype)init
{
    self = [super init];
    if (self)
        _argumentMatchers = [[NSMutableArray alloc] init];
    return self;
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    NSUInteger matchersCount = [self.argumentMatchers count];
    if (matchersCount <= argumentIndex)
    {
        [self trueUpArgumentMatchersToCount:argumentIndex];
        [self.argumentMatchers addObject:matcher];
    }
    else
        [self.argumentMatchers replaceObjectAtIndex:argumentIndex withObject:matcher];
}

- (NSUInteger)argumentMatchersCount
{
    return [self.argumentMatchers count];
}

- (void)trueUpArgumentMatchersToCount:(NSUInteger)desiredCount
{
    NSUInteger matchersCount = [self.argumentMatchers count];
    while (matchersCount < desiredCount)
    {
        [self.argumentMatchers addObject:[NSNull null]];
        ++matchersCount;
    } 
}

- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation
{
    self.expected = expectedInvocation;
    [self.expected retainArguments];
    
    NSMethodSignature *methodSignature = [self.expected methodSignature];
    
    self.numberOfArguments = [[self.expected methodSignature] numberOfArguments];
    [self trueUpArgumentMatchersToCount:self.numberOfArguments];
        
    for (NSUInteger argumentIndex = 2; argumentIndex < self.numberOfArguments; ++argumentIndex)
    {
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        if (typeEncodingIsObjectOrClass(argumentType))
        {
            __unsafe_unretained id argument = nil;
            [self.expected getArgument:&argument atIndex:argumentIndex];
            
            id <HCMatcher> matcher;
            if (argument != nil)
                matcher = HCWrapInMatcher(argument);
            else
                matcher = nilValue();
            
            [self setMatcher:matcher atIndex:argumentIndex];
        }
    }
}

- (BOOL)matches:(NSInvocation *)actual
{
    if ([self.expected selector] != [actual selector])
        return NO;

    NSArray *expectedArgs = [self.expected tk_arrayArguments];
    NSArray *actualArgs = [actual tk_arrayArguments];
    for (NSUInteger argumentIndex = 2; argumentIndex < self.numberOfArguments; ++argumentIndex)
    {
        id <HCMatcher> matcher = self.argumentMatchers[argumentIndex];
        if ([matcher isEqual:[NSNull null]])
            return [expectedArgs[argumentIndex - 2] isEqual:actualArgs[argumentIndex - 2]];
        else
        {
            id arg = actualArgs[argumentIndex - 2];
            if (arg == [NSNull null])
                arg = nil;
            if (![matcher matches:arg])
                return NO;
        }
    }
    return YES;
}

- (void)captureArgumentsFromInvocations:(NSArray *)invocations
{
    for (NSUInteger argumentIndex = 2; argumentIndex < self.numberOfArguments; ++argumentIndex)
    {
        id <HCMatcher> m = self.argumentMatchers[argumentIndex];
        if ([m respondsToSelector:@selector(captureArgument:)])
        {
            for (NSInvocation *invocation in invocations)
            {
                __unsafe_unretained id actualArgument;
                [invocation getArgument:&actualArgument atIndex:argumentIndex];
                [m performSelector:@selector(captureArgument:) withObject:actualArgument];
            }
        }
    }
}

@end
