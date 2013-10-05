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

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)index
{
    if ([self.argumentMatchers count] <= index)
    {
        [self trueUpArgumentMatchersToCount:index];
        [self.argumentMatchers addObject:matcher];
    }
    else
        [self.argumentMatchers replaceObjectAtIndex:index withObject:matcher];
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
    
    self.numberOfArguments = [[self.expected methodSignature] numberOfArguments] - 2;
    [self trueUpArgumentMatchersToCount:self.numberOfArguments];
        
    for (NSUInteger index = 0; index < self.numberOfArguments; ++index)
    {
        NSUInteger indexWithHiddenArgs = index + 2;
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:indexWithHiddenArgs];
        if (typeEncodingIsObjectOrClass(argumentType))
        {
            __unsafe_unretained id arg = nil;
            [self.expected getArgument:&arg atIndex:indexWithHiddenArgs];
            
            id <HCMatcher> matcher;
            if (arg != nil)
                matcher = HCWrapInMatcher(arg);
            else
                matcher = nilValue();

            [self setMatcher:matcher atIndex:index];
        }
    }
}

- (BOOL)matches:(NSInvocation *)actual
{
    if ([self.expected selector] != [actual selector])
        return NO;

    NSArray *expectedArgs = [self.expected tk_arrayArguments];
    NSArray *actualArgs = [actual tk_arrayArguments];
    for (NSUInteger index = 0; index < self.numberOfArguments; ++index)
    {
        id <HCMatcher> matcher = self.argumentMatchers[index];
        if ([matcher isEqual:[NSNull null]])
            return [expectedArgs[index] isEqual:actualArgs[index]];
        else
        {
            id arg = actualArgs[index];
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
    for (NSUInteger index = 0; index < self.numberOfArguments; ++index)
    {
        id <HCMatcher> matcher = self.argumentMatchers[index];
        if ([matcher respondsToSelector:@selector(captureArgument:)])
        {
            NSUInteger indexWithHiddenArgs = index + 2;
            for (NSInvocation *invocation in invocations)
            {
                __unsafe_unretained id actualArg;
                [invocation getArgument:&actualArg atIndex:indexWithHiddenArgs];
                [matcher performSelector:@selector(captureArgument:) withObject:actualArg];
            }
        }
    }
}

@end
