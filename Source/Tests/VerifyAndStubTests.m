//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2022 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
@import XCTest;

/*
 A --(useC:)--> B --(processStringFromC:)--> C
 */

@interface C: NSObject
@property (nonatomic, copy) NSString *text;
@end

@implementation C
@end

@interface B: NSObject
- (void)processStringFromC:(NSString *)string;
@end

@implementation B
- (void)processStringFromC:(NSString *)string { }
@end


@interface A: NSObject

- (void)useC:(C *)c;

@property (nonatomic, strong, readonly) B *b; // always uninitialized

@end

@implementation A

- (void)useC:(C *)c
{
    [self.b processStringFromC:c.text];
}

@end

@interface VerifyAndStubTests : XCTestCase
@end

@implementation VerifyAndStubTests
{
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)testStub_whileVerify
{
    // Given
    B *b = mock(B.class);
    C *c = mock(C.class);

    [given(c.text) willReturn:@"test"];

    // When
    [b processStringFromC:c.text];

    // Then
    [verify(b) processStringFromC:c.text];
}

- (void)testVerify_whileNotStubbing_ShouldFail
{
    // Given
    A *a = [[A alloc] init]; // A is not initialized with B
    B *b = mock(B.class); // not used at all
    C *c = [[C alloc] init]; // not stubbing

    // When
    [a useC:c];

    // Then
    [verifyWithMockTestCase(b, mockTestCase) processStringFromC:c.text];
    assertThat(@(mockTestCase.failureCount), is(@1));
}

- (void)testVerify_whileStubbing_ShouldFail
{
    // Given
    A *a = [[A alloc] init]; // A is not initialized with B
    B *b = mock(B.class); // not used at all
    C *c = mock(C.class); // stubbing

    // When
    [a useC:c];

    // Then
    [verifyWithMockTestCase(b, mockTestCase) processStringFromC:c.text];
    assertThat(@(mockTestCase.failureCount), is(@1));
}

@end
