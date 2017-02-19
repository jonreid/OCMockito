//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import "MockTestCase.h"
#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>


@protocol ObjectObserver <NSObject>
@end

@interface ObservableObject : NSObject
- (void)addObserver:(id <ObjectObserver>)observer;
- (void)removeObserver:(id <ObjectObserver>)observer;
@end

@implementation ObservableObject
- (void)addObserver:(id <ObjectObserver>)observer {}
- (void)removeObserver:(id <ObjectObserver>)observer {}
@end

@class ObservableObject;

@interface ObservingObject : NSObject <ObjectObserver>
@property (nonatomic, strong, readonly) ObservableObject *observableObject;
@end

@implementation ObservingObject

- (instancetype)initWithObservableObject:(ObservableObject *)observableObject
{
    self = [super init];
    if (self)
    {
        _observableObject = observableObject;
        [_observableObject addObserver:self];
    }
    return self;
}

/* A breakpoint on dealloc should be hit twice, at the conclusion of test1 and test2. If not, a
 * retain cycle has been introduced! */
- (void)dealloc
{
    [_observableObject removeObserver:self];
    /* When _observableObject is an active mock, this line causes trouble. Message arguments are
     * retained so they can be matched. But in a case like this, self is about to be destroyed. */
}

@end


@interface ObservingObjectTests : XCTestCase
@end

@implementation ObservingObjectTests
{
    ObservableObject *mockObservableObject;
    ObservingObject *observingObject;
}

- (void)setUp
{
    [super setUp];
    mockObservableObject = mock([ObservableObject class]);
    observingObject = [[ObservingObject alloc] initWithObservableObject:mockObservableObject];
}

- (void)tearDown
{
    stopMocking(mockObservableObject);
    mockObservableObject = nil;
    observingObject = nil;
    [super tearDown];
}

- (void)test1 {}
- (void)test2 {}

@end


@interface StopMockingProgrammerErrorTests : XCTestCase
@end

@implementation StopMockingProgrammerErrorTests
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

- (void)testStopMocking_WithNil_ShouldGiveError
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    stopMockingWithMockTestCase(nil, mockTestCase);
#pragma clang diagnostic pop

    assertThat(mockTestCase.failureDescription,
            is(@"Argument passed to stopMocking() should be a mock, but was nil"));
}

- (void)testStopMocking_WithNonMock_ShouldGiveError
{
    NSMutableArray *realArray = [NSMutableArray array];

    stopMockingWithMockTestCase(realArray, mockTestCase);

    assertThat(mockTestCase.failureDescription,
            startsWith(@"Argument passed to stopMocking() should be a mock, but was type "));
}

@end
