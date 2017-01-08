//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "DummyObject.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"


@implementation DummyObject

- (void)methodWithNoArgs {}
- (void)differentMethodWithNoArgs {}
- (void)methodWithObjectArg:(id)arg {}
- (void)differentMethodWithObjectArg:(id)arg {}
- (void)methodWithClassArg:(Class)arg {}
- (void)methodWithSelectorArg:(SEL)arg {}
- (void)methodWithBoolArg:(BOOL)arg {}
- (void)methodWithCharArg:(char)arg {}
- (void)methodWithIntArg:(int)arg {}
- (void)methodWithShortArg:(short)arg {}
- (void)methodWithLongArg:(long)arg {}
- (void)methodWithLongLongArg:(long long)arg {}
- (void)methodWithIntegerArg:(NSInteger)arg {}
- (void)methodWithUnsignedCharArg:(unsigned char)arg {}
- (void)methodWithUnsignedIntArg:(unsigned int)arg {}
- (void)methodWithUnsignedShortArg:(unsigned short)arg {}
- (void)methodWithUnsignedLongArg:(unsigned long)arg {}
- (void)methodWithUnsignedLongLongArg:(unsigned long long)arg {}
- (void)methodWithUnsignedIntegerArg:(NSUInteger)arg {}
- (void)methodWithFloatArg:(float)arg {}
- (void)methodWithDoubleArg:(double)arg {}
- (void)methodWithObjectArg1:(id)arg1 objectArg2:(id)arg2 {}
- (void)methodWithObjectArg:(id)arg1 intArg:(int)arg2 {}
- (void)methodWithIntArg:(int)arg1 floatArg:(float)arg2 {}

+ (NSInvocation *)invocationWithSelector:(SEL)selector
{
    NSMethodSignature *sig = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.selector = selector;
    return invocation;
}

+ (NSInvocation *)invocationWithNoArgs
{
    return [self invocationWithSelector:@selector(methodWithNoArgs)];
}

+ (NSInvocation *)differentInvocationWithNoArgs
{
    return [self invocationWithSelector:@selector(differentMethodWithNoArgs)];
}

+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithObjectArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)differentInvocationWithObjectArg:(__unsafe_unretained id)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(differentMethodWithObjectArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithClassArg:(Class)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithClassArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithSelectorArg:(SEL)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithSelectorArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithBoolArg:(BOOL)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithBoolArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithCharArg:(char)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithCharArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithIntArg:(int)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithShortArg:(short)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithShortArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithLongArg:(long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithLongArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithLongLongArg:(long long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithLongLongArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithIntegerArg:(NSInteger)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntegerArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedCharArg:(unsigned char)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedCharArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedIntArg:(unsigned int)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedIntArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedShortArg:(unsigned short)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedShortArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedLongArg:(unsigned long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedLongArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedLongLongArg:(unsigned long long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedLongLongArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedIntegerArg:(NSUInteger)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedIntegerArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithFloatArg:(float)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithFloatArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithDoubleArg:(double)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithDoubleArg:)];
    [inv setArgument:&argument atIndex:2];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument1 intArg:(int)argument2
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithObjectArg:intArg:)];
    [inv setArgument:&argument1 atIndex:2];
    [inv setArgument:&argument2 atIndex:3];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithObjectArg1:(__unsafe_unretained id)argument1 objectArg2:(__unsafe_unretained id)argument2
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithObjectArg1:objectArg2:)];
    [inv setArgument:&argument1 atIndex:2];
    [inv setArgument:&argument2 atIndex:3];
    [inv retainArguments];
    return inv;
}

+ (NSInvocation *)invocationWithIntArg:(int)argument1 floatArg:(float)argument2
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntArg:floatArg:)];
    [inv setArgument:&argument1 atIndex:2];
    [inv setArgument:&argument2 atIndex:3];
    [inv retainArguments];
    return inv;
}

@end


MKTInvocation *wrappedInvocation(NSInvocation *invocation)
{
    return [[MKTInvocation alloc] initWithInvocation:invocation];
}

MKTInvocation *wrappedInvocationWithLocation(NSInvocation *invocation, MKTLocation *location)
{
    return [[MKTInvocation alloc] initWithInvocation:invocation location:location];
}

MKTInvocationMatcher *matcherForInvocation(NSInvocation *invocation)
{
    MKTInvocationMatcher *matcher = [[MKTInvocationMatcher alloc] init];
    [matcher setExpectedInvocation:invocation];
    return matcher;
}
