//
//  OCMockito - MTMockitoCore.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTTestLocation.h"

@class MTClassMock;
@class MTOngoingStubbing;
@protocol MTVerificationMode;


@interface MTMockitoCore : NSObject

+ (id)sharedCore;

- (MTOngoingStubbing *)givenAtLocation:(MTTestLocation)location;

- (id)verifyMock:(MTClassMock *)mock
        withMode:(id <MTVerificationMode>)mode
      atLocation:(MTTestLocation)location;

@end
