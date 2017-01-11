//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <XCTest/XCTest.h>

#import "MockTestCase.h"
#import "ObservableObject.h"
#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>


@protocol StopAllMocksTestsProtocol <NSObject>

@required

- (NSInteger)requiredMethodWithParameter:(NSInteger)parameter;

@optional

- (NSString *)optionalMethodWithParameter:(NSString *)parameter;

@end


@interface StopAllMocksTests : XCTestCase
@end

@implementation StopAllMocksTests

- (void)tearDown
{
    stopAllMocks();
    [super tearDown];
}

- (void)testObjectMockExpectationsAreIgnored_AfterStoppingAllMocks
{
    NSString *mockObject = mock([NSString class]);

    [given([mockObject stringByAppendingString:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    [given([mockObject stringByAppendingString:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject stringByAppendingString:@"FOO"], is(nilValue()));
}

- (void)testNewObjectMocks_WorkAsExpected_AfterStoppingAllMocks
{
    NSString *mockObject = mock([NSString class]);

    [given([mockObject stringByAppendingString:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    mockObject = mock([NSString class]);
    [given([mockObject stringByAppendingString:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject stringByAppendingString:@"FOO"], is(equalTo(@"FOOBAR")));
}

- (void)testClassMockExpectationsAreIgnored_AfterStoppingAllMocks
{
    __strong Class mockObject = mockClass([NSArray class]);
    NSArray *array1 = @[];
    NSArray *array2 = @[];

    [given([mockObject array]) willReturn:array1];
    stopAllMocks();

    [given([mockObject array]) willReturn:array2];
    assertThat([mockObject array], is(nilValue()));
}

- (void)testNewClassMocks_WorkAsExpected_AfterStoppingAllMocks
{
    __strong Class mockObject = mockClass([NSArray class]);
    NSArray *array1 = @[];
    NSArray *array2 = @[];

    [given([mockObject array]) willReturn:array1];
    stopAllMocks();

    mockObject = mockClass([NSArray class]);
    [given([mockObject array]) willReturn:array2];
    assertThat([mockObject array], is(sameInstance(array2)));
}

- (void)testSingletonMocksAreReverted_AfterStoppingAllMocks
{
    __strong Class mockObject = mockClass([NSUserDefaults class]);
    NSUserDefaults *mockUserDefaults1 = mock([NSUserDefaults class]);
    NSUserDefaults *mockUserDefaults2 = mock([NSUserDefaults class]);
    stubSingleton(mockObject, standardUserDefaults);

    [given([mockObject standardUserDefaults]) willReturn:mockUserDefaults1];
    stopAllMocks();

    [given([mockObject standardUserDefaults]) willReturn:mockUserDefaults2];
    assertThat([NSUserDefaults standardUserDefaults], is(instanceOf([NSUserDefaults class])));
}

- (void)testNewSingletonMocks_WorkAsExpected_AfterStoppingAllMocks
{
    __strong Class mockObject = mockClass([NSUserDefaults class]);
    NSUserDefaults *mockUserDefaults1 = mock([NSUserDefaults class]);
    NSUserDefaults *mockUserDefaults2 = mock([NSUserDefaults class]);
    stubSingleton(mockObject, standardUserDefaults);

    [given([mockObject standardUserDefaults]) willReturn:mockUserDefaults1];
    stopAllMocks();

    mockObject = mockClass([NSUserDefaults class]);
    stubSingleton(mockObject, standardUserDefaults);
    [given([mockObject standardUserDefaults]) willReturn:mockUserDefaults2];
    assertThat([NSUserDefaults standardUserDefaults], is(sameInstance(mockUserDefaults2)));
}

- (void)testProtocolMockExpectationsAreIgnored_AfterStoppingAllMocks
{
    id<StopAllMocksTestsProtocol> mockObject = mockProtocol(@protocol(StopAllMocksTestsProtocol));

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject optionalMethodWithParameter:@"FOO"], is(nilValue()));
}

- (void)testNewProtocolMocks_WorkAsExpected_AfterStoppingAllMocks
{
    id<StopAllMocksTestsProtocol> mockObject = mockProtocol(@protocol(StopAllMocksTestsProtocol));

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    mockObject = mockProtocol(@protocol(StopAllMocksTestsProtocol));
    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject optionalMethodWithParameter:@"FOO"], is(equalTo(@"FOOBAR")));
}

- (void)testProtocolWithoutOptionalsMockExpectationsAreIgnored_AfterStoppingAllMocks
{
    id<StopAllMocksTestsProtocol> mockObject = mockProtocolWithoutOptionals(@protocol(StopAllMocksTestsProtocol));

    [given([mockObject requiredMethodWithParameter:1]) willReturn:@1];
    stopAllMocks();

    [given([mockObject requiredMethodWithParameter:1]) willReturn:@2];
    assertThatInteger([mockObject requiredMethodWithParameter:1], is(equalToInteger(0)));
}

- (void)testNewProtocolWithoutOptionalsMocks_WorkAsExpected_AfterStoppingAllMocks
{
    id<StopAllMocksTestsProtocol> mockObject = mockProtocolWithoutOptionals(@protocol(StopAllMocksTestsProtocol));

    [given([mockObject requiredMethodWithParameter:1]) willReturn:@1];
    stopAllMocks();

    mockObject = mockProtocolWithoutOptionals(@protocol(StopAllMocksTestsProtocol));
    [given([mockObject requiredMethodWithParameter:1]) willReturn:@2];
    assertThatInteger([mockObject requiredMethodWithParameter:1], is(equalToInteger(2)));
}

- (void)testObjectAndProtocolMockExpectationsAreIgnored_AfterStoppingAllMocks
{
    NSObject<StopAllMocksTestsProtocol> *mockObject = mockObjectAndProtocol([NSObject class], @protocol(StopAllMocksTestsProtocol));

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject optionalMethodWithParameter:@"FOO"], is(nilValue()));
}

- (void)testNewObjectAndProtocolMocks_WorkAsExpected_AfterStoppingAllMocks
{
    NSObject<StopAllMocksTestsProtocol> *mockObject = mockObjectAndProtocol([NSObject class], @protocol(StopAllMocksTestsProtocol));

    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"BAR"];
    stopAllMocks();

    mockObject = mockObjectAndProtocol([NSObject class], @protocol(StopAllMocksTestsProtocol));
    [given([mockObject optionalMethodWithParameter:@"FOO"]) willReturn:@"FOOBAR"];
    assertThat([mockObject optionalMethodWithParameter:@"FOO"], is(equalTo(@"FOOBAR")));
}

@end
