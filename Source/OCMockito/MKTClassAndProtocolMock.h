//
//  MKTClassAndProtocolMock.h
//  OCMockito
//
//  Created by Kevin Lundberg on 3/14/12.
//  Copyright (c) 2012 Jonathan M. Reid. All rights reserved.
//

#import "MKTProtocolMock.h"

/**
    Mock object of a given class that also implements a given protocol.
 */
@interface MKTClassAndProtocolMock : MKTProtocolMock

+ (id)mockForClass:(Class)cls protocol:(Protocol *)protocol;
- (id)initWithClass:(Class)cls protocol:(Protocol *)protocol;

@end
