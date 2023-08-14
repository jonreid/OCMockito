// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by David Hart

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


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
    SEL sel = NSSelectorFromString(@"text");

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
