//
//  OCMockito - MKTMockitoCore.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MKTestLocation.h"

@class MKTClassMock;
@class MKOngoingStubbing;
@protocol MKVerificationMode;


@interface MKTMockitoCore : NSObject

+ (id)sharedCore;

- (MKOngoingStubbing *)stubAtLocation:(MKTestLocation)location;

- (id)verifyMock:(MKTClassMock *)mock
        withMode:(id <MKVerificationMode>)mode
      atLocation:(MKTestLocation)location;

@end
