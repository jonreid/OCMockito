//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@interface StubSingletonProgrammerErrorTests : XCTestCase
@end

@implementation StubSingletonProgrammerErrorTests
{
    MockTestCase *mockTestCase;
}

- (void)setUp
{
    [super setUp];
    mockTestCase = [[MockTestCase alloc] init];
}

- (void)tearDown
{
    mockTestCase = nil;
    [super tearDown];
}

- (void)testStubSingleton_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    stubSingletonWithMockTestCase(nil, @selector(standardUserDefaults), mockTestCase);
#pragma clang diagnostic pop
    
    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to stubSingleton() should be a class mock, but was nil"));
}

- (void)testStubSingleton_WithObjectMock_ShouldGiveError
{
    id objectMock = mock([NSUserDefaults class]);
    
    stubSingletonWithMockTestCase(objectMock, @selector(standardUserDefaults), mockTestCase);
    
    assertThat(mockTestCase.failureDescription,
            is(@"Argument passed to stubSingleton() should be a class mock, but was type MKTObjectMock"));
}

- (void)testStubSingleton_WithNoSuchSingleton_ShouldGiveError
{
    id classMock = mockClass([NSArray class]);
    
    stubSingletonWithMockTestCase(classMock, @selector(standardUserDefaults), mockTestCase);
    
    assertThat(mockTestCase.failureDescription,
            is(@"Method name passed to stubSingleton() should be a class method of NSArray, but was standardUserDefaults"));
}

@end
