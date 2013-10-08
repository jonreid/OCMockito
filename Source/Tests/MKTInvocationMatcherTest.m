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
- (void)methodWithIntArg:(int)arg1 floatArg:(float)arg2 {}

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
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithFloatArg:)];
    [inv setArgument:&argument atIndex:2];
    return inv;
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

+ (NSInvocation *)invocationWithIntArg:(int)argument1 floatArg:(float)argument2
{
    NSInvocation *inv = [self invocationWithSelector:@selector(methodWithIntArg:floatArg:)];
    [inv setArgument:&argument1 atIndex:2];
    [inv setArgument:&argument2 atIndex:3];
    return inv;
}

@end


#pragma mark -

@interface MKTInvocationMatcherTest : SenTestCase
{
    MKTInvocationMatcher *invocationMatcher;
}
@end

@implementation MKTInvocationMatcherTest

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
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithNoArgs]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithNoArgs]], nil);
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
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithObjectArg:@"something"]], nil);
}

- (void)testShouldMatchIfObjectArgumentsAreNil
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:nil]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithObjectArg:nil]], nil);
}

- (void)testShouldNotMatchIfObjectArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithObjectArg:@"different"]], nil);
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
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithObjectArg:@"something"]], nil);
}

- (void)testShouldNotMatchIfObjectArgumentDoesNotSatisfyArgumentExpectation
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithObjectArg:@"different"]], nil);
}

- (void)testShouldMatchIfBoolArgumentEqualsExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithBoolArg:YES]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithBoolArg:YES]], nil);
}

- (void)testShouldNotMatchIfBoolArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithBoolArg:NO]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithBoolArg:YES]], nil);
}

- (void)testShouldMatchIfCharArgumentEqualsExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithCharArg:'a']], nil);
}

- (void)testShouldNotMatchIfCharArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithCharArg:'z']], nil);
}

- (void)testNotShouldMatchIfCharArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    [invocationMatcher setMatcher:lessThan(@'n') atIndex:0];
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithCharArg:0]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithCharArg:'z']], nil);
}

- (void)testShouldNotMatchIfIntArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithIntArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithIntArg:99]], nil);
}

- (void)testShouldNotMatchIfIntArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    [invocationMatcher setMatcher:lessThan(@50) atIndex:0];
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithCharArg:0]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithCharArg:51]], nil);
}

- (void)testShouldNotMatchIfShortArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithShortArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithShortArg:99]], nil);
}

- (void)testShouldNotMatchIfLongArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithLongArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithLongArg:99]], nil);
}

- (void)testShouldNotMatchIfLongLongArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithLongLongArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithLongLongArg:99]], nil);
}

- (void)testShouldNotMatchIfIntegerArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithIntegerArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithIntegerArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedCharArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedCharArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedCharArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedIntArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedIntArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedIntArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedShortArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedShortArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedShortArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedLongArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedLongArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedLongArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedLongLongArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedLongLongArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedLongLongArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedIntegerArgumentDoesNotEqualExpectedArgument
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithUnsignedIntegerArg:42]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithUnsignedIntegerArg:99]], nil);
}

- (void)testShouldNotMatchIfFloatArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    [invocationMatcher setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithFloatArg:0]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithFloatArg:3.14f]], nil);
}

- (void)testShouldNotMatchIfDoubleArgumentConvertedToObjectDoesNotSatisfyOverrideMatcher
{
    [invocationMatcher setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithDoubleArg:0]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithDoubleArg:3.14]], nil);
}

- (void)testShouldMatchOverrideMatcherSpecifiedForSecondPrimitiveArgument
{
    [invocationMatcher setMatcher:greaterThan(@50) atIndex:1];
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something" intArg:0]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithObjectArg:@"something" intArg:51]], nil);
}

- (void)testMultiplePrimitivesWithAllMatching_ShouldMatch
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];
    STAssertTrue([invocationMatcher matches:[DummyObject invocationWithIntArg:0 floatArg:3.14f]], nil);
}

- (void)testMultiplePrimitivesWithFirstArgNotMatching_ShouldNotMatch
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithIntArg:99 floatArg:3.14f]], nil);
}

- (void)testMultiplePrimitivesWithSecondArgNotMatching_ShouldNotMatch
{
    [invocationMatcher setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];
    STAssertFalse([invocationMatcher matches:[DummyObject invocationWithIntArg:0 floatArg:2.718f]], nil);
}

- (void)testArgumentMatchersCount_ShouldReflectLargestSetMatcherIndex
{
    [invocationMatcher setMatcher:equalTo(@"irrelevant") atIndex:1];
    [invocationMatcher setMatcher:equalTo(@"irrelevant") atIndex:0];
    assertThatUnsignedInteger([invocationMatcher argumentMatchersCount], equalTo(@2));
}

@end
