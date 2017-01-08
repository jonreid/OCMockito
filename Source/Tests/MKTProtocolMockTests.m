//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@protocol TestingProtocol <NSObject>

@required
- (NSString *)required;

@optional
- (NSString *)optional;

@end


@interface PartialImplementer : NSObject <TestingProtocol>
@end

@implementation PartialImplementer

- (NSString *)required
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

- (NSString *)optional
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

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
}

- (void)testShouldAnswerSameMethodSignatureForOptionalSelectorAsRealImplementer
{
    FullImplementer *realImplementer = [[FullImplementer alloc] init];
    SEL sel = @selector(optional);

    NSMethodSignature *signature = [(id)mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
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

    NSMethodSignature *signature = [(id) mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo(nil));
}

- (void)testSignatureOfOptionalMethod_WhenOptionalMethodsAreIncluded_ShouldAnswerSameSignatureAsRealImplementer
{
    PartialImplementer *realImplementer = [[PartialImplementer alloc] init];
    SEL sel = @selector(optional);

    NSMethodSignature *signature = [(id) mockImplementer methodSignatureForSelector:sel];

    assertThat(signature, equalTo([realImplementer methodSignatureForSelector:sel]));
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
}

- (void)testShouldRespondToOptionalSelector
{
    XCTAssertTrue([mockImplementer respondsToSelector:@selector(optional)]);
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
