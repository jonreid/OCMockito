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
- (BOOL)objectArgumentMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index;
- (BOOL)charArgumentMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index;
- (BOOL)intArgumentMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index;
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
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        if (strcmp(argumentType, @encode(id)) == 0)
        {
            if ([self objectArgumentMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(char)) == 0)
        {
            if ([self charArgumentMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(int)) == 0)
        {
            if ([self intArgumentMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
    }
    
    return YES;
}


- (BOOL)objectArgumentMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index
{
    id actualArgument;
    [actual getArgument:&actualArgument atIndex:index];
    
    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    return ![matcher matches:actualArgument];
}


#define DEFINE_ARGUMENT_MISMATCH_METHOD(type, Type)                                                 \
    - (BOOL)type ## ArgumentMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index   \
    {                                                                                               \
        type actualArgument;                                                                        \
        [actual getArgument:&actualArgument atIndex:index];                                         \
                                                                                                    \
        id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];                            \
        if ([matcher isEqual:[NSNull null]])                                                        \
        {                                                                                           \
            type expectedArgument;                                                                  \
            [expected getArgument:&expectedArgument atIndex:index];                                 \
            return expectedArgument != actualArgument;                                              \
        }                                                                                           \
        else                                                                                        \
            return ![matcher matches:[NSNumber numberWith ## Type :actualArgument]];                \
    }

DEFINE_ARGUMENT_MISMATCH_METHOD(char, Char)
DEFINE_ARGUMENT_MISMATCH_METHOD(int, Int)

@end
