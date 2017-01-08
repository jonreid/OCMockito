//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt
//  Contribution by Ceri Hughes

#import <XCTest/XCTest.h>

#import "MockTestCase.h"
#import "ObservableObject.h"
#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>


@interface DisableMockingTestsHelper : NSObject <ObjectObserver>
@property (nonatomic, strong, readonly) ObservableObject *observableObject1;
@property (nonatomic, strong, readonly) ObservableObject *observableObject2;
@end

@implementation DisableMockingTestsHelper

- (instancetype)initWithObservableObject1:(ObservableObject *)observableObject1
                        observableObject2:(ObservableObject *)observableObject2
{
    self = [super init];
    if (self) {
        _observableObject1 = observableObject1;
        _observableObject2 = observableObject2;
        [_observableObject1 addObserver:self];
    }
    return self;
}

- (void)dealloc
{
    [_observableObject1 removeObserver:self];
    [_observableObject2 removeObserver:self];
}

@end


@interface DisableMockingTests : XCTestCase
@end

@implementation DisableMockingTests
{
    NSMutableArray *trackedMocks;
}

- (void)setUp
{
    [super setUp];
    trackedMocks = [NSMutableArray array];
}

- (void)tearDown
{
    // Without this disableMocking stage, 1 of the tests will fail, as we'll create a strong ref from
    // a mock to an object that's being deallocated. The only other option would be for the test to know
    // the correct order of stopMocking calls, which means that the test would need implementation-
    // specific knowledge.
    for (id trackedMock in trackedMocks) {
        disableMocking(trackedMock);
    }

    while (trackedMocks.count > 0) {
        id trackedMock = trackedMocks.firstObject;
        stopMocking(trackedMock);
        [trackedMocks removeObjectAtIndex:0];
    }

    trackedMocks = nil;

    [super tearDown];
}

- (void)testStoppingMocks_Object1ThenObject2_ShouldNotCrash
{
    ObservableObject *mockObservableObject1 = mock([ObservableObject class]);
    ObservableObject *mockObservableObject2 = mock([ObservableObject class]);

    [trackedMocks addObject:mockObservableObject1];
    [trackedMocks addObject:mockObservableObject2];
    
    [[DisableMockingTestsHelper alloc] initWithObservableObject1:mockObservableObject1
                                               observableObject2:mockObservableObject2];
}

- (void)testStoppingMocks_Object2ThenObject1_ShouldNotCrash
{
    ObservableObject *mockObservableObject1 = mock([ObservableObject class]);
    ObservableObject *mockObservableObject2 = mock([ObservableObject class]);

    [trackedMocks addObject:mockObservableObject2];
    [trackedMocks addObject:mockObservableObject1];
    
    [[DisableMockingTestsHelper alloc] initWithObservableObject1:mockObservableObject1
                                               observableObject2:mockObservableObject2];
}

@end


@interface DisableMockingProgrammerErrorTests : XCTestCase
@end

@implementation DisableMockingProgrammerErrorTests
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

- (void)testDisableMocking_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    disableMockingWithMockTestCase(nil, mockTestCase);
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
               is(@"Argument passed to disableMocking() should be a mock, but was nil"));
}

- (void)testDisableMocking_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    disableMockingWithMockTestCase(realArray, mockTestCase);

    assertThat(mockTestCase.failureDescription,
               startsWith(@"Argument passed to disableMocking() should be a mock, but was type "));
}

@end
