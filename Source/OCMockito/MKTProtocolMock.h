//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import "MKTBaseMockObject.h"


/**
 Mock object implementing a given protocol.
 */
@interface MKTProtocolMock : MKTBaseMockObject

@property (readonly, nonatomic, strong) Protocol *mockedProtocol;

+ (instancetype)mockForProtocol:(Protocol *)aProtocol;
- (instancetype)initWithProtocol:(Protocol *)aProtocol;

@end
