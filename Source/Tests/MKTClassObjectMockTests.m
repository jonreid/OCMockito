//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface MKTClassObjectMockTests : XCTestCase
@end

@implementation MKTClassObjectMockTests
{
    __strong Class mockStringClass;
}

- (void)setUp
{
    [super setUp];
    mockStringClass = mockClass([NSString class]);
}

- (void)tearDown
{
    mockStringClass = Nil;
    [super tearDown];
}

- (void)testDescription
{
    assertThat([mockStringClass description], is(@"mock class of NSString"));
}

- (void)testMock_ShouldAnswerSameMethodSignatureForSelectorAsRealObject
{
    SEL sel = @selector(string);

    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:sel];

    assertThat(signature, is(equalTo([[NSString class] methodSignatureForSelector:sel])));
}

- (void)testMethodSignatureForSelectorNotInClass_ShouldAnswerNil
{
    SEL sel = @selector(rangeOfString:options:);

    NSMethodSignature *signature = [mockStringClass methodSignatureForSelector:sel];

    assertThat(signature, is(nilValue()));
}

- (void)testShouldRespondToKnownSelector
{
    XCTAssertTrue([mockStringClass respondsToSelector:@selector(pathWithComponents:)]);
}

- (void)testShouldNotRespondToUnknownSelector
{
    XCTAssertFalse([mockStringClass respondsToSelector:@selector(pathExtension)]);
}

@end
