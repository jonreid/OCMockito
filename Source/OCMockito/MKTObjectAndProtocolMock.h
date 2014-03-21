//
//  OCMockito - MKTObjectAndProtocolMock.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//  
//  Created by: Kevin Lundberg
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTObjectMock.h"


/**
 Mock object of a given class that also implements a given protocol.
 */
@interface MKTObjectAndProtocolMock : MKTObjectMock

+ (instancetype)mockForClass:(Class)aClass protocol:(Protocol *)aProtocol;
- (instancetype)initWithClass:(Class)aClass protocol:(Protocol *)aProtocol;

@end
