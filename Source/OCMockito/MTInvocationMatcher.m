//
//  OCMockito - MTInvocationMatcher.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationMatcher.h"

#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
    #import <OCHamcrest/HCWrapInMatcher.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
    #import <OCHamcrestIOS/HCWrapInMatcher.h>
#endif


@interface MTInvocationMatcher ()
@property(nonatomic, retain) NSInvocation *expected;
@property(nonatomic, retain) NSMutableArray *argumentMatchers;
@property(nonatomic, assign) NSUInteger numberOfArguments;
@end


@implementation MTInvocationMatcher

@synthesize expected;
@synthesize argumentMatchers;
@synthesize numberOfArguments;


- (id)init
{
    self = [super init];
    if (self)
        argumentMatchers = [[NSMutableArray alloc] initWithObjects:[NSNull null], [NSNull null], nil];
    return self;
}


- (void)dealloc
{
    [expected release];
    [argumentMatchers release];
    [super dealloc];
}


- (void)setMatcher:(id <HCMatcher>)matcher forIndex:(NSUInteger)index
{
    [argumentMatchers addObject:matcher];
}


- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation
{
    [self setExpected:expectedInvocation];
    [expected retainArguments];
    
    NSMethodSignature *methodSignature = [expected methodSignature];
    
    numberOfArguments = [[expected methodSignature] numberOfArguments];
    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++argumentIndex)
    {
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        if (strcmp(argumentType, @encode(id)) == 0)
        {
            id argument = nil;
            [expected getArgument:&argument atIndex:argumentIndex];
            [argumentMatchers addObject:HCWrapInMatcher(argument)];
        }
        else
        {
            if ([argumentMatchers count] <= argumentIndex)
                [argumentMatchers addObject:[NSNull null]];
        }
    }
}


- (BOOL)matches:(NSInvocation *)actual
{
    if ([expected selector] != [actual selector])
        return NO;

    NSMethodSignature *methodSignature = [expected methodSignature];

    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++argumentIndex)
    {
        id <HCMatcher> matcher = [argumentMatchers objectAtIndex:argumentIndex];
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        if (strcmp(argumentType, @encode(id)) == 0)
        {
            id actualArgument;
            [actual getArgument:&actualArgument atIndex:argumentIndex];
            
            if (![matcher matches:actualArgument])
                return NO;
        }
        else if (strcmp(argumentType, @encode(char)) == 0)
        {
            char actualArgument;
            [actual getArgument:&actualArgument atIndex:argumentIndex];
            
            if ([matcher isEqual:[NSNull null]])
            {
                char expectedArgument;
                [expected getArgument:&expectedArgument atIndex:argumentIndex];
                if (expectedArgument != actualArgument)
                    return NO;
            }
            else
            {
                if (![matcher matches:[NSNumber numberWithChar:actualArgument]])
                    return NO;
            }
        }
    }
    
    return YES;
}

@end
