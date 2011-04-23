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


@interface ReturningObject : NSObject
@end

@implementation ReturningObject

- (id)methodReturningObject { return self; }
- (id)methodReturningObjectWithArg:(id)arg { return self; }
- (id)methodReturningObjectWithIntArg:(int)arg { return self; }

@end


#pragma mark -

@interface StubTest : SenTestCase
@end


@implementation StubTest

- (void)testStubbedMethodWithNoArgsReturningObject
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


- (void)testShortcutForSpecifyingMatcherForFirstArgument
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [[given([mockObject methodReturningObjectWithIntArg:0])
      withMatcher:greaterThan([NSNumber numberWithInt:1])] willReturn:@"FOO"];
    
    assertThat([mockObject methodReturningObjectWithIntArg:2], is(@"FOO"));
}

@end
