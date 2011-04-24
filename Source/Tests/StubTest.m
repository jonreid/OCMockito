//
//  OCMockito - StubTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
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

struct Foo {
    int i;
};
typedef struct Foo Foo;

@interface ReturningObject : NSObject
@end

@implementation ReturningObject

- (id)methodReturningObject { return self; }
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

@end


#pragma mark -

@interface StubTest : SenTestCase
@end


@implementation StubTest

- (void)testStubbedMethoShouldReturnGivenObject
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningObject]) willReturn:@"STUBBED"];
    
    assertThat([mockObject methodReturningObject], is(@"STUBBED"));
}


- (void)testUnstubbedMethodReturningObjectShouldReturnNil
{
    ReturningObject *mockObject = mock([ReturningObject class]);
        
    assertThat([mockObject methodReturningObject], is(nilValue()));
}


- (void)testStubsWithDifferentArgsShouldHaveDifferentReturnValues
{
    ReturningObject *mockObject = mock([ReturningObject class]);

    [given([mockObject methodReturningObjectWithArg:@"foo"]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithArg:@"bar"]) willReturn:@"BAR"];

    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}


- (void)testStubShouldAcceptArgumentMatchers
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}


- (void)testStubShouldReturnValueForMatchingNumericArgument
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningObjectWithIntArg:1]) willReturn:@"FOO"];
    [given([mockObject methodReturningObjectWithIntArg:2]) willReturn:@"BAR"];
    
    assertThat([mockObject methodReturningObjectWithIntArg:1], is(@"FOO"));
}


- (void)testStubShouldAcceptMatcherForNumericArgument
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [[given([mockObject methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan([NSNumber numberWithInt:1]) forArgument:0] willReturn:@"FOO"];
    
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}


- (void)testShouldSupportShortcutForSpecifyingMatcherForFirstArgument
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [[given([mockObject methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan([NSNumber numberWithInt:1])] willReturn:@"FOO"];
    
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}


- (void)testStubbedMethodShouldReturnGivenBool
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningBool]) willReturnBool:YES];
    
    STAssertTrue([mockObject methodReturningBool], nil);
}


- (void)testStubbedMethodShouldReturnGivenChar
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningChar]) willReturnChar:'a'];
    
    assertThatChar([mockObject methodReturningChar], equalToChar('a'));
}


- (void)testStubbedMethodShouldReturnGivenInt
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningInt]) willReturnInt:42];
    
    assertThatInt([mockObject methodReturningInt], equalToInt(42));
}


- (void)testStubbedMethodShouldReturnGivenShort
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningShort]) willReturnShort:42];
    
    assertThatShort([mockObject methodReturningShort], equalToShort(42));
}


- (void)testStubbedMethodShouldReturnGivenLong
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningLong]) willReturnLong:42];
    
    assertThatLong([mockObject methodReturningLong], equalToLong(42));
}


- (void)testStubbedMethodShouldReturnGivenLongLong
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningLongLong]) willReturnLongLong:42];
    
    assertThatLongLong([mockObject methodReturningLongLong], equalToLongLong(42));
}


- (void)testStubbedMethodShouldReturnGivenInteger
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningInteger]) willReturnInteger:42];
    
    assertThatInteger([mockObject methodReturningInteger], equalToInteger(42));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedChar
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedChar]) willReturnUnsignedChar:'a'];
    
    assertThatUnsignedChar([mockObject methodReturningUnsignedChar], equalToUnsignedChar('a'));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedInt
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedInt]) willReturnUnsignedInt:42];
    
    assertThatUnsignedInt([mockObject methodReturningUnsignedInt], equalToUnsignedInt(42));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedShort
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedShort]) willReturnUnsignedShort:42];
    
    assertThatUnsignedShort([mockObject methodReturningUnsignedShort], equalToUnsignedShort(42));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedLong
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedLong]) willReturnUnsignedLong:42];
    
    assertThatUnsignedLong([mockObject methodReturningUnsignedLong], equalToUnsignedLong(42));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedLongLong
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedLongLong]) willReturnUnsignedLongLong:42];
    
    assertThatUnsignedLongLong([mockObject methodReturningUnsignedLongLong], equalToUnsignedLongLong(42));
}


- (void)testStubbedMethodShouldReturnGivenUnsignedInteger
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningUnsignedInteger]) willReturnUnsignedInteger:42];
    
    assertThatUnsignedInteger([mockObject methodReturningUnsignedInteger], equalToUnsignedInteger(42));
}


- (void)testStubbedMethodShouldReturnGivenFloat
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [mockObject methodReturningFloat];
    [givenPreviousCall willReturnFloat:42];
    
    assertThatFloat([mockObject methodReturningFloat], equalToFloat(42));
}


- (void)testStubbedMethodShouldReturnGivenDouble
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [mockObject methodReturningDouble];
    [givenPreviousCall willReturnDouble:42];
    
    assertThatDouble([mockObject methodReturningDouble], equalToDouble(42));
}

@end
