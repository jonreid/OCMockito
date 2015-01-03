//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

// System under test
#import "MKTInvocationMatcher.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


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

@interface MKTInvocationMatcherTests : SenTestCase
{
    MKTInvocationMatcher *sut;
}
@end

@implementation MKTInvocationMatcherTests

- (void)setUp
{
    [super setUp];
    sut = [[MKTInvocationMatcher alloc] init];
}

- (void)tearDown
{
    sut = nil;
    [super tearDown];
}

- (void)testInvocationWithNoArgs_WithSameSelectors_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithNoArgs]];

    STAssertTrue([sut matches:[DummyObject invocationWithNoArgs]], nil);
}

- (void)testInvocationWithNoArgs_WithDifferentSelectors_ShouldNotMatch
{
    NSInvocation *expected = [DummyObject invocationWithNoArgs];
    NSInvocation *actual = [DummyObject invocationWithNoArgs];
    [expected setSelector:@selector(methodWithNoArgs)];
    [actual setSelector:@selector(differentMethodWithNoArgs)];

    [sut setExpectedInvocation:expected];

    STAssertFalse([sut matches:actual], nil);
}

- (void)testInvocationWithObjectArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];

    STAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something"]], nil);
}

- (void)testInvocationWithObjectArg_WithNilArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:nil]];

    STAssertTrue([sut matches:[DummyObject invocationWithObjectArg:nil]], nil);
}

- (void)testInvocationWithObjectArg_WithDifferentArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something"]];

    STAssertFalse([sut matches:[DummyObject invocationWithObjectArg:@"different"]], nil);
}

- (void)testInvocationWithObjectArg_WithEqualArgsButDifferentSelectors_ShouldNotMatch
{
    NSInvocation *expected = [DummyObject invocationWithObjectArg:@"something"];
    NSInvocation *actual = [DummyObject invocationWithObjectArg:@"something"];
    [expected setSelector:@selector(methodWithObjectArg:)];
    [actual setSelector:@selector(differentMethodWithObjectArg:)];

    [sut setExpectedInvocation:expected];

    STAssertFalse([sut matches:actual], nil);
}

- (void)testInvocationWithObjectArg_WithArgumentSatisfyingMatcher_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];

    STAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something"]], nil);
}

- (void)testInvocationWithObjectArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:equalTo(@"something")]];

    STAssertFalse([sut matches:[DummyObject invocationWithObjectArg:@"different"]], nil);
}

- (void)testInvocationWithBoolArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithBoolArg:YES]];

    STAssertTrue([sut matches:[DummyObject invocationWithBoolArg:YES]], nil);
}

- (void)testInvocationWithBoolArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithBoolArg:NO]];

    STAssertFalse([sut matches:[DummyObject invocationWithBoolArg:YES]], nil);
}

- (void)testInvocationWithCharArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];

    STAssertTrue([sut matches:[DummyObject invocationWithCharArg:'a']], nil);
}

- (void)testInvocationWithCharArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:'a']];

    STAssertFalse([sut matches:[DummyObject invocationWithCharArg:'z']], nil);
}

- (void)testInvocationWithCharArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:lessThan(@'n') atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:0]];

    STAssertFalse([sut matches:[DummyObject invocationWithCharArg:'z']], nil);
}

- (void)testInvocationWithIntArg_WithEqualArgs_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithIntArg:99]], nil);
}

- (void)testInvocationWithIntArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:lessThan(@50) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithCharArg:0]];

    STAssertFalse([sut matches:[DummyObject invocationWithCharArg:51]], nil);
}

- (void)testInvocationWithIntArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithShortArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithShortArg:99]], nil);
}

- (void)testInvocationWithLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithLongArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithLongArg:99]], nil);
}

- (void)testInvocationWithLongLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithLongLongArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithLongLongArg:99]], nil);
}

- (void)testInvocationWithIntegerArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntegerArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithIntegerArg:99]], nil);
}

- (void)testInvocationWithUnsignedCharArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedCharArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedCharArg:99]], nil);
}

- (void)testInvocationWithUnsignedIntArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedIntArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedIntArg:99]], nil);
}

- (void)testInvocationWithUnsignedShortArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedShortArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedShortArg:99]], nil);
}

- (void)testShouldNotMatchIfUnsignedLongArgumentDoesNotEqualExpectedArgument
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedLongArg:42]];
    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedLongArg:99]], nil);
}

- (void)testInvocationWithUnsignedLongLongArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedLongLongArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedLongLongArg:99]], nil);
}

- (void)testInvocationWithUnsignedIntegerArg_WithUnequalArgs_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithUnsignedIntegerArg:42]];

    STAssertFalse([sut matches:[DummyObject invocationWithUnsignedIntegerArg:99]], nil);
}

- (void)testInvocationWithFloatArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithFloatArg:0]];

    STAssertFalse([sut matches:[DummyObject invocationWithFloatArg:3.14f]], nil);
}

- (void)testInvocationWithDoubleArg_WithOverrideMatcherNotSatisfied_ShouldNotMatch
{
    [sut setMatcher:closeTo(3.5, 0.1) atIndex:0];
    [sut setExpectedInvocation:[DummyObject invocationWithDoubleArg:0]];

    STAssertFalse([sut matches:[DummyObject invocationWithDoubleArg:3.14]], nil);
}

- (void)testInvocation_WithOverrideMatcherForSecondArgumentSatisfied_ShouldMatch
{
    [sut setMatcher:greaterThan(@50) atIndex:1];
    [sut setExpectedInvocation:[DummyObject invocationWithObjectArg:@"something" intArg:0]];

    STAssertTrue([sut matches:[DummyObject invocationWithObjectArg:@"something" intArg:51]], nil);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithAllArgsEqual_ShouldMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    STAssertTrue([sut matches:[DummyObject invocationWithIntArg:0 floatArg:3.14f]], nil);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithFirstArgsUnequal_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    STAssertFalse([sut matches:[DummyObject invocationWithIntArg:99 floatArg:3.14f]], nil);
}

- (void)testInvocationWithMultiplePrimitiveArgs_WithSecondArgsUnequal_ShouldNotMatch
{
    [sut setExpectedInvocation:[DummyObject invocationWithIntArg:0 floatArg:3.14f]];

    STAssertFalse([sut matches:[DummyObject invocationWithIntArg:0 floatArg:2.718f]], nil);
}

- (void)testArgumentMatchersCount_ShouldReflectLargestSetMatcherIndex
{
    [sut setMatcher:equalTo(@"IRRELEVANT") atIndex:1];
    [sut setMatcher:equalTo(@"IRRELEVANT") atIndex:0];

    assertThat(@([sut argumentMatchersCount]), is(@2));
}

@end
