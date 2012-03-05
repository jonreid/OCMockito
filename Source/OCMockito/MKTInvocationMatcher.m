//
//  OCMockito - MKTInvocationMatcher.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTInvocationMatcher.h"

#define HC_SHORTHAND

#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
    #import <OCHamcrest/HCWrapInMatcher.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
    #import <OCHamcrestIOS/HCWrapInMatcher.h>
#endif


@interface MKTInvocationMatcher ()
@property (nonatomic, retain) NSInvocation *expected;
@property (nonatomic, retain) NSMutableArray *argumentMatchers;
@property (nonatomic, assign) NSUInteger numberOfArguments;
- (void)trueUpArgumentMatchersToCount:(NSUInteger)desiredCount;
@end


@implementation MKTInvocationMatcher

@synthesize expected;
@synthesize argumentMatchers;
@synthesize numberOfArguments;

- (id)init
{
    self = [super init];
    if (self)
        argumentMatchers = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc
{
    [expected release];
    [argumentMatchers release];
    [super dealloc];
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    NSUInteger matchersCount = [argumentMatchers count];
    if (matchersCount <= argumentIndex)
    {
        [self trueUpArgumentMatchersToCount:argumentIndex];
        [argumentMatchers addObject:matcher];
    }
    else
        [argumentMatchers replaceObjectAtIndex:argumentIndex withObject:matcher];
}

- (NSUInteger)argumentMatchersCount
{
    return [argumentMatchers count];
}

- (void)trueUpArgumentMatchersToCount:(NSUInteger)desiredCount
{
    NSUInteger matchersCount = [argumentMatchers count];
    while (matchersCount < desiredCount)
    {
        [argumentMatchers addObject:[NSNull null]];
        ++matchersCount;
    }
}

- (void)setExpectedInvocation:(NSInvocation *)expectedInvocation
{
    [self setExpected:expectedInvocation];
    [expected retainArguments];

    NSMethodSignature *methodSignature = [expected methodSignature];

    numberOfArguments = [[expected methodSignature] numberOfArguments];
    [self trueUpArgumentMatchersToCount:numberOfArguments];

    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++argumentIndex)
    {
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:argumentIndex];
        if (strcmp(argumentType, @encode(id)) == 0)
        {
            id argument = nil;
            [expected getArgument:&argument atIndex:argumentIndex];

            id <HCMatcher> matcher;
            if (argument != nil)
                matcher = HCWrapInMatcher(argument);
            else
                matcher = nilValue();

            [self setMatcher:matcher atIndex:argumentIndex];
        }
    }
}

- (BOOL)argumentObjectMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index
{
    id actualArgument;
    [actual getArgument:&actualArgument atIndex:index];

    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    return ![matcher matches:actualArgument];
}

- (BOOL)argumentPointMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index {
    NSPoint actualArgument;
    [actual getArgument:&actualArgument atIndex:index];
    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    if ([matcher isEqual:[NSNull null]]) {
        NSPoint expectedArgument;
        [expected getArgument:&expectedArgument atIndex:index];
        return !NSEqualPoints(expectedArgument, actualArgument);
    } else return ![matcher matches:[NSValue valueWithPoint:actualArgument]];
}

- (BOOL)argumentSizeMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index {
    NSSize actualArgument;
    [actual getArgument:&actualArgument atIndex:index];
    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    if ([matcher isEqual:[NSNull null]]) {
        NSSize expectedArgument;
        [expected getArgument:&expectedArgument atIndex:index];
        return !NSEqualSizes(expectedArgument, actualArgument);
    } else return ![matcher matches:[NSValue valueWithSize:actualArgument]];
}

- (BOOL)argumentRectMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index {
    NSRect actualArgument;
    [actual getArgument:&actualArgument atIndex:index];
    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    if ([matcher isEqual:[NSNull null]]) {
        NSRect expectedArgument;
        [expected getArgument:&expectedArgument atIndex:index];
        return !NSEqualRects(expectedArgument, actualArgument);
    } else return ![matcher matches:[NSValue valueWithRect:actualArgument]];
}

- (BOOL)argumentRangeMismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index {
    NSRange actualArgument;
    [actual getArgument:&actualArgument atIndex:index];
    id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];
    if ([matcher isEqual:[NSNull null]]) {
        NSRange expectedArgument;
        [expected getArgument:&expectedArgument atIndex:index];
        return !NSEqualRanges(expectedArgument, actualArgument);
    } else return ![matcher matches:[NSValue valueWithRange:actualArgument]];
}

#define DEFINE_ARGUMENT_MISMATCH_METHOD(type, typeName)                                     \
    - (BOOL)argument ## typeName ## MismatchInInvocation:(NSInvocation *)actual atIndex:(NSUInteger)index \
    {                                                                                       \
        type actualArgument;                                                                \
        [actual getArgument:&actualArgument atIndex:index];                                 \
                                                                                            \
        id <HCMatcher> matcher = [argumentMatchers objectAtIndex:index];                    \
        if ([matcher isEqual:[NSNull null]])                                                \
        {                                                                                   \
            type expectedArgument;                                                          \
            [expected getArgument:&expectedArgument atIndex:index];                         \
            return expectedArgument != actualArgument;                                      \
        }                                                                                   \
        else                                                                                \
            return ![matcher matches:[NSNumber numberWith ## typeName :actualArgument]];    \
    }

DEFINE_ARGUMENT_MISMATCH_METHOD(char, Char)
DEFINE_ARGUMENT_MISMATCH_METHOD(int, Int)
DEFINE_ARGUMENT_MISMATCH_METHOD(short, Short)
DEFINE_ARGUMENT_MISMATCH_METHOD(long, Long)
DEFINE_ARGUMENT_MISMATCH_METHOD(long long, LongLong)
DEFINE_ARGUMENT_MISMATCH_METHOD(unsigned char, UnsignedChar)
DEFINE_ARGUMENT_MISMATCH_METHOD(unsigned int, UnsignedInt)
DEFINE_ARGUMENT_MISMATCH_METHOD(unsigned short, UnsignedShort)
DEFINE_ARGUMENT_MISMATCH_METHOD(unsigned long, UnsignedLong)
DEFINE_ARGUMENT_MISMATCH_METHOD(unsigned long long, UnsignedLongLong)
DEFINE_ARGUMENT_MISMATCH_METHOD(float, Float)
DEFINE_ARGUMENT_MISMATCH_METHOD(double, Double)


#define HANDLE_ARGUMENT_TYPE(type, typeName)                                                    \
    else if (strcmp(argumentType, @encode(type)) == 0)                                          \
    {                                                                                           \
        if ([self argument ## typeName ## MismatchInInvocation:actual atIndex:argumentIndex])   \
            return NO;                                                                          \
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
            if ([self argumentObjectMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(NSPoint)) == 0) {
            if ([self argumentPointMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(NSSize)) == 0) {
            if ([self argumentSizeMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(NSRect)) == 0) {
            if ([self argumentRectMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        else if (strcmp(argumentType, @encode(NSRange)) == 0) {
            if ([self argumentRangeMismatchInInvocation:actual atIndex:argumentIndex])
                return NO;
        }
        HANDLE_ARGUMENT_TYPE(char, Char)
        HANDLE_ARGUMENT_TYPE(int, Int)
        HANDLE_ARGUMENT_TYPE(short, Short)
        HANDLE_ARGUMENT_TYPE(long, Long)
        HANDLE_ARGUMENT_TYPE(long long, LongLong)
        HANDLE_ARGUMENT_TYPE(unsigned char, UnsignedChar)
        HANDLE_ARGUMENT_TYPE(unsigned int, UnsignedInt)
        HANDLE_ARGUMENT_TYPE(unsigned short, UnsignedShort)
        HANDLE_ARGUMENT_TYPE(unsigned long, UnsignedLong)
        HANDLE_ARGUMENT_TYPE(unsigned long long, UnsignedLongLong)
        HANDLE_ARGUMENT_TYPE(float, Float)
        HANDLE_ARGUMENT_TYPE(double, Double)
    }
    
    return YES;
}

@end
