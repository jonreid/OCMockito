//
//  OCMockito - MKTInvocationMatcherTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

// System under test
#import "MKTInvocationMatcher.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface DummyObject : NSObject
@end

@implementation DummyObject

- (void)methodWithNoArgs {}
- (void)differentMethodWithNoArgs {}

- (void)methodWithObjectArg:(id)arg {}
- (void)differentMethodWithObjectArg:(id)arg {}

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

- (void)methodWithObjectArg:(id)arg1 intArg:(int)arg2 {}

+ (NSInvocation *)invocationWithSelector:(SEL)selector
{
    NSMethodSignature *sig = [self instanceMethodSignatureForSelector:selector];
    return [NSInvocation invocationWithMethodSignature:sig];
}

+ (NSInvocation *)invocationWithNoArgs
{
    return [self invocationWithSelector:@selector(methodWithNoArgs)];
}

+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithObjectArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithBoolArg:(BOOL)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithBoolArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithCharArg:(char)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithCharArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithIntArg:(int)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithShortArg:(short)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithShortArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithLongArg:(long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithLongArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithLongLongArg:(long long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithLongLongArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithIntegerArg:(NSInteger)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntegerArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedCharArg:(unsigned char)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedCharArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedIntArg:(unsigned int)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedIntArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedShortArg:(unsigned short)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedShortArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedLongArg:(unsigned long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedLongArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedLongLongArg:(unsigned long long)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedLongLongArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithUnsignedIntegerArg:(NSUInteger)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithUnsignedIntegerArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithFloatArg:(float)argument
{
    NSInvocation *invocation = [self invocationWithSelector:@selector(methodWithFloatArg:)];
    [invocation setArgument:&argument atIndex:2];
    return invocation;
}

+ (NSInvocation *)invocationWithDoubleArg:(double)argument
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithDoubleArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
}

+ (NSInvocation *)invocationWithObjectArg:(__unsafe_unretained id)argument1 intArg:(int)argument2
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithObjectArg:intArg:)];
    [inv setArgument:&argument1 atIndex:2];
    [inv setArgument:&argument2 atIndex:3];
    return inv;
}

@end


#pragma mark -

@interface MKTInvocationMatcherTest : SenTestCase
@end

@implementation MKTInvocationMatcherTest
{
    MKTInvocationMatcher *invocationMatcher;
}

- (void)setUp
{
    [super setUp];
    invocationMatcher = [[MKTInvocationMatcher alloc] init];
}

- (void)tearDown
{
	invocationMatcher = nil;
    [super tearDown];
}

- (void)testShouldMatchNoArgumentInvocationsIfSelectorsMatch
{
    NSInvocation *expected = [DummyObject invocationWithNoArgs];
    NSInvocation *actual = [DummyObject invocationWithNoArgs];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchNoArgumentInvocationsIfSelectorsDiffer
{
    NSInvocation *expected = [DummyObject invocationWithNoArgs];
    NSInvocation *actual = [DummyObject invocationWithNoArgs];
    [expected setSelector:@selector(methodWithNoArgs)];
    [actual setSelector:@selector(differentMethodWithNoArgs)];
    
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchIfObjectArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something"];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"something"];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchIfObjectArgumentsAreNil
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:nil];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:nil];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfObjectArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something"];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"different"];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfArgumentsMatchButSelectorsDiffer
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something"];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"something"];
    [expected setSelector:@selector(methodWithObjectArg:)];
    [actual setSelector:@selector(differentMethodWithObjectArg:)];
    
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchIfObjectArgumentSatisfiesArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [DummyObject invocationWithObjectArg:argumentExpectation];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"something"];
    
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfObjectArgumentDoesNotSatisfyArgumentExpectation
{
    id <HCMatcher> argumentExpectation = equalTo(@"something");
    NSInvocation *expected = [DummyObject invocationWithObjectArg:argumentExpectation];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"different"];
    
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchIfBoolArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithBoolArg:YES];
    NSInvocation *actual = [DummyObject invocationWithBoolArg:YES];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfBoolArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithBoolArg:NO];
    NSInvocation *actual = [DummyObject invocationWithBoolArg:YES];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchIfCharArgumentEqualsExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithCharArg:'a'];
    NSInvocation *actual = [DummyObject invocationWithCharArg:'a'];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfCharArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithCharArg:'a'];
    NSInvocation *actual = [DummyObject invocationWithCharArg:'z'];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testNotShouldMatchIfCharArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    NSInvocation *expected = [DummyObject invocationWithCharArg:0];   // Argument will be ignored.
    NSInvocation *actual = [DummyObject invocationWithCharArg:'z'];
    
    [invocationMatcher setMatcher:lessThan(@'n') atIndex:2];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfIntArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithIntArg:42];
    NSInvocation *actual = [DummyObject invocationWithIntArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfIntArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    NSInvocation *expected = [DummyObject invocationWithCharArg:0];   // Argument will be ignored.
    NSInvocation *actual = [DummyObject invocationWithCharArg:51];
    
    [invocationMatcher setMatcher:lessThan(@50) atIndex:2];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfShortArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithShortArg:42];
    NSInvocation *actual = [DummyObject invocationWithShortArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfLongArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithLongArg:42];
    NSInvocation *actual = [DummyObject invocationWithLongArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfLongLongArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithLongLongArg:42];
    NSInvocation *actual = [DummyObject invocationWithLongLongArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfIntegerArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithIntegerArg:42];
    NSInvocation *actual = [DummyObject invocationWithIntegerArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedCharArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedCharArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedCharArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedIntArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedIntArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedIntArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedShortArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedShortArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedShortArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedLongArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedLongArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedLongArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedLongLongArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedLongLongArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedLongLongArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfUnsignedIntegerArgumentDoesNotEqualExpectedArgument
{
    NSInvocation *expected = [DummyObject invocationWithUnsignedIntegerArg:42];
    NSInvocation *actual = [DummyObject invocationWithUnsignedIntegerArg:99];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfFloatArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    NSInvocation *expected = [DummyObject invocationWithFloatArg:0];   // Argument will be ignored.
    NSInvocation *actual = [DummyObject invocationWithFloatArg:3.14f];
    
    [invocationMatcher setMatcher:closeTo(3.5, 0.1) atIndex:2];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldNotMatchIfDoubleArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    NSInvocation *expected = [DummyObject invocationWithDoubleArg:0];   // Argument will be ignored.
    NSInvocation *actual = [DummyObject invocationWithDoubleArg:3.14];
    
    [invocationMatcher setMatcher:closeTo(3.5, 0.1) atIndex:2];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertFalse([invocationMatcher matches:actual], nil);
}

- (void)testShouldMatchOverrideMatcherSpecifiedForSecondPrimitiveArgument
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something" intArg:0];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"something" intArg:51];
    
    [invocationMatcher setMatcher:greaterThan(@50) atIndex:3];
    [invocationMatcher setExpectedInvocation:expected];
    STAssertTrue([invocationMatcher matches:actual], nil);
}

- (void)testArgumentMatchersCount_ShouldReflectLargestSetMatcherIndex
{
    [invocationMatcher setMatcher:equalTo(@"irrelevant") atIndex:3];
    [invocationMatcher setMatcher:equalTo(@"irrelevant") atIndex:2];
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], equalToUnsignedInteger(4));
}

@end
