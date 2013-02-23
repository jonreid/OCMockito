//
//  OCMockito - StubObjectTest.m
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
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


@interface ReturningObject : NSObject

typedef struct {
  int aMember;
} aStruct;

@end

@implementation ReturningObject

- (id)methodReturningObject { return self; }
- (Class)methodReturningClass { return [self class]; }
- (Class)methodReturningClassWithClassArg:(Class)arg { return [self class]; }
- (id)methodReturningObjectWithArg:(id)arg { return self; }
- (id)methodReturningObjectWithIntArg:(int)arg { return self; }

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
- (aStruct)methodReturningStruct { aStruct returnedStruct = {0}; return returnedStruct; }

@end


#pragma mark -

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

- (void)testStubbedMethodShouldReturnGivenObject
{
    // when
    [given([mockObject methodReturningObject]) willReturn:@"STUBBED"];
    
    // then
    assertThat([mockObject methodReturningObject], is(@"STUBBED"));
}

- (void)testUnstubbedMethodReturningObjectShouldReturnNil
{
    // then
    assertThat([mockObject methodReturningObject], is(nilValue()));
}

- (void)testStubbedMethodShouldReturnGivenClass
{
    // when
    [given([mockObject methodReturningClass]) willReturn:[NSString class]];
    
    // then
    assertThat([mockObject methodReturningClass], is([NSString class]));
}

- (void)testUnstubbedMethodReturningClassShouldReturnNull
{
    assertThat([mockObject methodReturningClass], is(nilValue()));
}

- (void)testStubbedMethodShouldReturnOnMatchingArgument
{
    // when
    [given([mockObject methodReturningClassWithClassArg:[NSString class]]) willReturn:[NSString class]];
    
    // then
    assertThat([mockObject methodReturningClassWithClassArg:[NSData class]], is(nilValue()));
    assertThat([mockObject methodReturningClassWithClassArg:[NSString class]], is([NSString class]));
}

- (void)testStubsWithDifferentArgsShouldHaveDifferentReturnValues
{
    // when
    [given([mockObject methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];
    
    // then
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubShouldAcceptArgumentMatchers
{
    // when
    [given([mockObject methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    
    // then
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

- (void)testStubShouldReturnValueForMatchingNumericArgument
{
    // when
    [given([mockObject methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];
    
    // then
    assertThat([mockObject methodReturningObjectWithIntArg:1], is(@"FOO"));
}

- (void)testStubShouldAcceptMatcherForNumericArgument
{
    // when
    [[given([mockObject methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan(@1) forArgument:0] willReturn:@"FOO"];
    
    // then
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    // when
    [[given([mockObject methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan(@1)] willReturn:@"FOO"];
    
    // then
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}

- (void)testStubbedMethodShouldReturnGivenBool
{
    // when
    [given([mockObject methodReturningBool]) willReturnBool:YES];
    
    // then
    STAssertTrue([mockObject methodReturningBool], nil);
}

- (void)testStubbedMethodShouldReturnGivenChar
{
    // when
    [given([mockObject methodReturningChar]) willReturnChar:'a'];
    
    // then
    assertThatChar([mockObject methodReturningChar], equalToChar('a'));
}

- (void)testStubbedMethodShouldReturnGivenInt
{
    // when
    [given([mockObject methodReturningInt]) willReturnInt:42];
    
    // then
    assertThatInt([mockObject methodReturningInt], equalToInt(42));
}

- (void)testStubbedMethodShouldReturnGivenShort
{
    // when
    [given([mockObject methodReturningShort]) willReturnShort:42];
    
    // then
    assertThatShort([mockObject methodReturningShort], equalToShort(42));
}

- (void)testStubbedMethodShouldReturnGivenLong
{
    // when
    [given([mockObject methodReturningLong]) willReturnLong:42];
    
    // then
    assertThatLong([mockObject methodReturningLong], equalToLong(42));
}

- (void)testStubbedMethodShouldReturnGivenLongLong
{
    // when
    [given([mockObject methodReturningLongLong]) willReturnLongLong:42];
    
    // then
    assertThatLongLong([mockObject methodReturningLongLong], equalToLongLong(42));
}

- (void)testStubbedMethodShouldReturnGivenInteger
{
    // when
    [given([mockObject methodReturningInteger]) willReturnInteger:42];
    
    // then
    assertThatInteger([mockObject methodReturningInteger], equalToInteger(42));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedChar
{
    // when
    [given([mockObject methodReturningUnsignedChar]) willReturnUnsignedChar:'a'];
    
    // then
    assertThatUnsignedChar([mockObject methodReturningUnsignedChar], equalToUnsignedChar('a'));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedInt
{
    // when
    [given([mockObject methodReturningUnsignedInt]) willReturnUnsignedInt:42];
    
    // then
    assertThatUnsignedInt([mockObject methodReturningUnsignedInt], equalToUnsignedInt(42));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedShort
{
    // when
    [given([mockObject methodReturningUnsignedShort]) willReturnUnsignedShort:42];
    
    // then
    assertThatUnsignedShort([mockObject methodReturningUnsignedShort], equalToUnsignedShort(42));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedLong
{
    // when
    [given([mockObject methodReturningUnsignedLong]) willReturnUnsignedLong:42];
    
    // then
    assertThatUnsignedLong([mockObject methodReturningUnsignedLong], equalToUnsignedLong(42));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedLongLong
{
    // when
    [given([mockObject methodReturningUnsignedLongLong]) willReturnUnsignedLongLong:42];
    
    // then
    assertThatUnsignedLongLong([mockObject methodReturningUnsignedLongLong], equalToUnsignedLongLong(42));
}

- (void)testStubbedMethodShouldReturnGivenUnsignedInteger
{
    // when
    [given([mockObject methodReturningUnsignedInteger]) willReturnUnsignedInteger:42];
    
    // then
    assertThatUnsignedInteger([mockObject methodReturningUnsignedInteger], equalToUnsignedInteger(42));
}

- (void)testStubbedMethodShouldReturnGivenFloat
{
    // when
    [given([mockObject methodReturningFloat]) willReturnFloat:42.5];
    
    // then
    assertThatFloat([mockObject methodReturningFloat], equalToFloat(42.5));
}

- (void)testStubbedMethodShouldReturnGivenDouble
{
    // when
    [given([mockObject methodReturningDouble]) willReturnDouble:42];
    
    // then
    assertThatDouble([mockObject methodReturningDouble], equalToDouble(42));
}

- (void)testStubbedMethodShouldReturnGivenStruct
{
  int anInt = 123;
  aStruct someStruct = { anInt };

  // when
  [given([mockObject methodReturningStruct]) willReturnStruct:&someStruct];
  someStruct = [mockObject methodReturningStruct];

  // then
  assertThat(@(someStruct.aMember), is(@(anInt)));
}

@end
