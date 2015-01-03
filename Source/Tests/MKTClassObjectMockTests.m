//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt
//  Contribution by David Hart

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>


@interface MKTClassObjectMockTests : SenTestCase
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
    STAssertTrue([mockStringClass respondsToSelector:@selector(pathWithComponents:)], nil);
}

- (void)testShouldNotRespondToUnknownSelector
{
    STAssertFalse([mockStringClass respondsToSelector:@selector(pathExtension)], nil);
}

@end
