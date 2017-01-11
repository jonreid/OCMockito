//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@interface MKTMockitoTracker : NSObject

+ (instancetype)sharedTracker;

- (id)createAndTrackMockObject:(Class)classToMock;
- (id)createAndTrackMockClass:(Class)classToMock;
- (id)createAndTrackMockProtocol:(Protocol *)protocolToMock;
- (id)createAndTrackMockProtocolWithoutOptionals:(Protocol *)protocolToMock;
- (id)createAndTrackMockObject:(Class)classToMock andProtocol:(Protocol *)protocolToMock;

- (void)stopTrackedMocks;

@end
