//
//  OCMockito - MKTProtocolMock.h
//  Copyright 2012 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>
#import "MKTPrimitiveArgumentMatching.h"


/**
    Mock object implementing a given protocol.
 */
@interface MKTProtocolMock : NSProxy <MKTPrimitiveArgumentMatching>

+ (id)mockForProtocol:(Protocol *)aClass;
- (id)initWithProtocol:(Protocol *)aClass;

@end
