//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@protocol TestingProtocol <NSObject>

@required
- (NSString *)required;
+ (NSString *)classRequired;

@optional
- (NSString *)optional;
+ (NSString *)classOptional;

@end


@interface PartialImplementer : NSObject <TestingProtocol>
@end

@implementation PartialImplementer

- (NSString *)required
{
    return nil;
}

+ (NSString *)classRequired
{
    return nil;
}

@end


@interface FullImplementer : NSObject <TestingProtocol>
@end

@implementation FullImplementer

- (NSString *)required
{
    return nil;
}

+ (NSString *)classRequired
{
    return nil;
}

- (NSString *)optional
{
    return nil;
}

+ (NSString *)classOptional
{
    return nil;
}

@end


@interface MKTProtocolMockTests : XCTestCase
@end

@implementation MKTProtocolMockTests
{
    id <TestingProtocol> mockImplementer;
}

- (void)setUp
{
    [super setUp];
    mockImplementer = mockProtocol(@protocol(TestingProtocol));
}

- (void)tearDown
{
    mockImplementer = nil;
    [super tearDown];
}

- (void)testDescription
{
    assertThat([mockImplementer description], is(@"mock implementer of TestingProtocol protocol"));
}

- (void)testShouldAnswerSameMethodSignatureForRequiredSelectorAsRealImplementer
{
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL sel = @selector(required);
    SEL classSel = @selector(classRequired);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];
    NSMethodSignature *classSignature = [(id)mockImplementer methodSignatureForSelector:classSel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
    assertThat(classSignature, equalTo([realImplementer.class methodSignatureForSelector:classSel]));
}

- (void)testShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL sel = @selector(optional);
    SEL classSel = @selector(classOptional);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];
    NSMethodSignature *classSignature = [(id)mockImplementer methodSignatureForSelector:classSel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
    assertThat(classSignature, equalTo([realImplementer.class methodSignatureForSelector:classSel]));
}

- (void)testMethodSignatureForSelectorNotInProtocol_ShouldAnswerNil
{
    SEL sel = @selector(objectAtIndex:);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, is(nilValue()));
}

- (void)testSignatureOfOptionalMethod_WhenOptionalMethodsAreNotIncluded_ShouldBeNil
{
    mockImplementer = mockProtocolWithoutOptionals(@protocol(TestingProtocol));
    SEL sel = @selector(optional);
    SEL classSel = @selector(classOptional);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];
    NSMethodSignature *classSignature = [(id)mockImplementer methodSignatureForSelector:classSel];

    assertThat(signature, equalTo(nil));
    assertThat(classSignature, equalTo(nil));
}

- (void)testSignatureOfOptionalMethod_WhenOptionalMethodsAreIncluded_ShouldAnswerSameSignatureAsRealImplementer
{
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL sel = @selector(optional);
    SEL classSel = @selector(classOptional);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];
    NSMethodSignature *classSignature = [(id)mockImplementer methodSignatureForSelector:classSel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
    assertThat(classSignature, equalTo([realImplementer.class methodSignatureForSelector:classSel]));
}

- (void)testShouldConformToItsOwnProtocol
{
    XCTAssertTrue([mockImplementer conformsToProtocol:@protocol(TestingProtocol)]);
}

- (void)testShouldConformToParentProtocol
{
    XCTAssertTrue([mockImplementer conformsToProtocol:@protocol(NSObject)]);
}

- (void)testShouldNotConformToUnrelatedProtocol
{
    XCTAssertFalse([mockImplementer conformsToProtocol:@protocol(NSCoding)]);
}

- (void)testShouldRespondToRequiredSelector
{
    XCTAssertTrue([mockImplementer respondsToSelector:@selector(required)]);
    XCTAssertTrue([mockImplementer respondsToSelector:@selector(classRequired)]);
}

- (void)testShouldRespondToOptionalSelector
{
    XCTAssertTrue([mockImplementer respondsToSelector:@selector(optional)]);
    XCTAssertTrue([mockImplementer respondsToSelector:@selector(classOptional)]);
}

- (void)testShouldNotRespondToUnrelatedSelector
{
    XCTAssertFalse([mockImplementer respondsToSelector:@selector(objectAtIndex:)]);
}

- (void)testDescriptionOfCollectionWithMockProtocol_ShouldNotCrash
{
    id <NSObject> mockedProtocol = mockProtocol(@protocol(NSObject));
    NSArray *array = @[ mockedProtocol ];
    
    NSString *description = array.description;
    
    XCTAssertNotNil(description);
}

@end
