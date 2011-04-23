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


- (void)testStubsShouldAcceptArgumentMatchers
{
    ReturningObject *mockObject = mock([ReturningObject class]);
    
    [given([mockObject methodReturningObjectWithArg:equalTo(@"foo")]) willReturn:@"FOO"];
    
    assertThat([mockObject methodReturningObjectWithArg:@"foo"], is(@"FOO"));
}

@end
