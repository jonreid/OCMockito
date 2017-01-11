//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTMockitoTracker.h"

#import "OCMockito.h"

@interface MKTMockitoTracker ()
@property (nonatomic, strong, readonly) NSMutableArray<MKTBaseMockObject *> *trackedMocks;
@end

@implementation MKTMockitoTracker

+ (instancetype)sharedTracker
{
    static id sharedTracker = nil;
    if (!sharedTracker)
        sharedTracker = [[self alloc] init];
    return sharedTracker;
}

- (instancetype)init
{
    self = [super init];
    if (self)
        _trackedMocks = [NSMutableArray array];
    return self;
}

- (id)createAndTrackMockObject:(Class)classToMock
{
    id theMock = [[MKTObjectMock alloc] initWithClass:classToMock];
    [self.trackedMocks addObject:theMock];
    return theMock;
}

- (id)createAndTrackMockClass:(Class)classToMock
{
    id theMock = [[MKTClassObjectMock alloc] initWithClass:classToMock];
    [self.trackedMocks addObject:theMock];
    return theMock;
}

- (id)createAndTrackMockProtocol:(Protocol *)protocolToMock
{
    id theMock = [[MKTProtocolMock alloc] initWithProtocol:protocolToMock includeOptionalMethods:YES];
    [self.trackedMocks addObject:theMock];
    return theMock;
}

- (id)createAndTrackMockProtocolWithoutOptionals:(Protocol *)protocolToMock
{
    id theMock = [[MKTProtocolMock alloc] initWithProtocol:protocolToMock includeOptionalMethods:NO];
    [self.trackedMocks addObject:theMock];
    return theMock;
}

- (id)createAndTrackMockObject:(Class)classToMock andProtocol:(Protocol *)protocolToMock
{
    id theMock = [[MKTObjectAndProtocolMock alloc] initWithClass:classToMock protocol:protocolToMock];
    [self.trackedMocks addObject:theMock];
    return theMock;
}

- (void)stopTrackedMocks
{
    NSArray *trackedMocksCopy = nil;
    @synchronized (self.trackedMocks) {
        trackedMocksCopy = [self.trackedMocks copy];
        [self.trackedMocks removeAllObjects];
    }

    for (MKTBaseMockObject *mock in trackedMocksCopy) {
        [mock disableMocking];
    }

    for (MKTBaseMockObject *mock in trackedMocksCopy) {
        [mock stopMocking];
    }
}

- (void)addMock:(MKTBaseMockObject *)mock
{
    @synchronized (self.trackedMocks) {
        [self.trackedMocks addObject:mock];
    }
}

@end
