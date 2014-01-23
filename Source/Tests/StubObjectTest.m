//
//  OCMockito - StubObjectTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif

typedef void (^StubObjectBlockArgument)(void);

typedef struct {
    int anInt;
    char aChar;
    double *arrayOfDoubles;
} MKTStruct;

double *createArrayOf10Doubles(void)
{
    return malloc(10*sizeof(double));
}


@interface ReturningObject : NSObject
@end

@implementation ReturningObject

- (id)methodReturningObject { return self; }
- (Class)methodReturningClass { return [self class]; }
- (Class)methodReturningClassWithClassArg:(Class)arg { return [self class]; }
- (id)methodReturningObjectWithArg:(id)arg { return self; }
- (id)methodReturningObjectWithIntArg:(int)arg { return self; }
- (id)methodReturningObjectWithBlockArg:(StubObjectBlockArgument)arg { return self; }
- (id)methodReturningObjectWithStruct:(MKTStruct)arg { return NO; };

- (BOOL)methodReturningBool { return NO; }
- (char)methodReturningChar { return 0; }
- (int)methodReturningInt { return 0; }
- (short)methodReturningShort { return 0; }
- (long)methodReturningLong { return 0; }
- (long long)methodReturningLongLong { return 0; }
- (NSInteger)methodReturningInteger { return 0; }
- (unsigned char)methodReturningUnsignedChar { return 0; }
- (unsigned int)methodReturningUnsignedInt { return 0; }
- (unsigned short)methodReturningUnsignedShort { return 0; }
- (unsigned long)methodReturningUnsignedLong { return 0; }
- (unsigned long long)methodReturningUnsignedLongLong { return 0; }
- (NSUInteger)methodReturningUnsignedInteger { return 0; }
- (float)methodReturningFloat { return 0; }
- (double)methodReturningDouble { return 0; }

@end


@interface StubObjectTest : SenTestCase
@end

@implementation StubObjectTest
{
    ReturningObject *mockObject;
}

- (void)setUp
{
    [super setUp];
    mockObject = mock([ReturningObject class]);
}

- (void)testStubbedMethod_ShouldReturnGivenObject
{
    [given([mockObject methodReturningObject]) willReturn:@"STUBBED"];
    assertThat([mockObject methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObject_ShouldReturnNil
{
    assertThat([mockObject methodReturningObject], is(nilValue()));
}

- (void)testStubbedMethod_ShouldReturnGivenClass
{
    [given([mockObject methodReturningClass]) willReturn:[NSString class]];
    assertThat([mockObject methodReturningClass], is([NSString class]));
}

- (void)testUnstubbedMethodReturningClass_ShouldReturnNull
{
    assertThat([mockObject methodReturningClass], is(nilValue()));
}

- (void)testStubbedMethod_ShouldReturnOnMatchingArgument
{
    [given([mockObject methodReturningClassWithClassArg:[NSString class]]) willReturn:[NSString class]];
    assertThat([mockObject methodReturningClassWithClassArg:[NSData class]], is(nilValue()));
    assertThat([mockObject methodReturningClassWithClassArg:[NSString class]], is([NSString class]));
}

- (void)testStubsWithDifferentArgs_ShouldHaveDifferentReturnValues
{
    [given([mockObject methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldAcceptArgumentMatchers
{
    [given([mockObject methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStub_ShouldReturnValueForMatchingNumericArgument
{
    [given([mockObject methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];
    assertThat([mockObject methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStub_ShouldReturnValueForSameBlockArgument
{
    StubObjectBlockArgument block = ^{ };
    [given([mockObject methodReturningObjectWithBlockArg:block]) willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithBlockArg:block], is(@"FOO"));
}

- (void)testStub_ShouldReturnNilForInlineBlockArgument
{
    [given([mockObject methodReturningObjectWithBlockArg:^{ }])
     willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithBlockArg:^{ }], is(nilValue()));
}

- (void)testStub_ShouldReturnNilForInlineBlockArgumentCapturingScopeVariable
{
    NSNumber *someVariable = @0;
    [given([mockObject methodReturningObjectWithBlockArg:^{ [someVariable description]; }])
     willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithBlockArg:^{ [someVariable description]; }], is(nilValue()));
}

- (void)testStub_ShouldNotReturnValueForMatchingBlockArgument
{
    StubObjectBlockArgument emptyBlock = ^{ };
    StubObjectBlockArgument anotherEmptyBlock = ^{ };
    [given([mockObject methodReturningObjectWithBlockArg:emptyBlock]) willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithBlockArg:anotherEmptyBlock], isNot(@"FOO"));
}

- (void)testStub_ShouldReturnValueForSameStructArgument
{
    double *a = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};
    [given([mockObject methodReturningObjectWithStruct:struct1]) willReturn:@"FOO"];

    assertThat([mockObject methodReturningObjectWithStruct:struct1], is(@"FOO"));

    free(a);
}

- (void)testStub_ShouldReturnValueForMatchingStructArgument
{
    double *a = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', a};
    [given([mockObject methodReturningObjectWithStruct:struct1]) willReturn:@"FOO"];

    assertThat([mockObject methodReturningObjectWithStruct:struct2], is(@"FOO"));

    free(a);
}

- (void)testStub_ShoulReturnNilForNotMatchingStructArgument
{
    double *a = createArrayOf10Doubles();
    double *b = createArrayOf10Doubles();
    MKTStruct struct1 = {1, 'a', a};
    MKTStruct struct2 = {1, 'a', b};
    [given([mockObject methodReturningObjectWithStruct:struct1]) willReturn:@"FOO"];

    assertThat([mockObject methodReturningObjectWithStruct:struct2], is(nilValue()));

    free(a);
    free(b);
}

- (void)testStub_ShouldAcceptMatcherForNumericArgument
{
    [[given([mockObject methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    [[given([mockObject methodReturningObjectWithIntArg:0])
            withMatcher:greaterThan(@1)] willReturn:@"FOO"];
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethod_ShouldReturnGivenBool
{
    [given([mockObject methodReturningBool]) willReturnBool:YES];
    STAssertTrue([mockObject methodReturningBool], nil);
}

- (void)testStubbedMethod_ShouldReturnGivenChar
{
    [given([mockObject methodReturningChar]) willReturnChar:'a'];
    assertThatChar([mockObject methodReturningChar], equalToChar('a'));
}

- (void)testStubbedMethod_ShouldReturnGivenInt
{
    [given([mockObject methodReturningInt]) willReturnInt:42];
    assertThatInt([mockObject methodReturningInt], equalToInt(42));
}

- (void)testStubbedMethod_ShouldReturnGivenShort
{
    [given([mockObject methodReturningShort]) willReturnShort:42];
    assertThatShort([mockObject methodReturningShort], equalToShort(42));
}

- (void)testStubbedMethod_ShouldReturnGivenLong
{
    [given([mockObject methodReturningLong]) willReturnLong:42];
    assertThatLong([mockObject methodReturningLong], equalToLong(42));
}

- (void)testStubbedMethod_ShouldReturnGivenLongLong
{
    [given([mockObject methodReturningLongLong]) willReturnLongLong:42];
    assertThatLongLong([mockObject methodReturningLongLong], equalToLongLong(42));
}

- (void)testStubbedMethod_ShouldReturnGivenInteger
{
    [given([mockObject methodReturningInteger]) willReturnInteger:42];
    assertThatInteger([mockObject methodReturningInteger], equalToInteger(42));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedChar
{
    [given([mockObject methodReturningUnsignedChar]) willReturnUnsignedChar:'a'];
    assertThatUnsignedChar([mockObject methodReturningUnsignedChar], equalToUnsignedChar('a'));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedInt
{
    [given([mockObject methodReturningUnsignedInt]) willReturnUnsignedInt:42];
    assertThatUnsignedInt([mockObject methodReturningUnsignedInt], equalToUnsignedInt(42));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedShort
{
    [given([mockObject methodReturningUnsignedShort]) willReturnUnsignedShort:42];
    assertThatUnsignedShort([mockObject methodReturningUnsignedShort], equalToUnsignedShort(42));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedLong
{
    [given([mockObject methodReturningUnsignedLong]) willReturnUnsignedLong:42];
    assertThatUnsignedLong([mockObject methodReturningUnsignedLong], equalToUnsignedLong(42));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedLongLong
{
    [given([mockObject methodReturningUnsignedLongLong]) willReturnUnsignedLongLong:42];
    assertThatUnsignedLongLong([mockObject methodReturningUnsignedLongLong], equalToUnsignedLongLong(42));
}

- (void)testStubbedMethod_ShouldReturnGivenUnsignedInteger
{
    [given([mockObject methodReturningUnsignedInteger]) willReturnUnsignedInteger:42];
    assertThatUnsignedInteger([mockObject methodReturningUnsignedInteger], equalToUnsignedInteger(42));
}

- (void)testStubbedMethod_ShouldReturnGivenFloat
{
    [given([mockObject methodReturningFloat]) willReturnFloat:42.5];
    assertThatFloat([mockObject methodReturningFloat], equalToFloat(42.5));
}

- (void)testStubbedMethod_ShouldReturnGivenDouble
{
    [given([mockObject methodReturningDouble]) willReturnDouble:42];
    assertThatDouble([mockObject methodReturningDouble], equalToDouble(42));
}

@end
