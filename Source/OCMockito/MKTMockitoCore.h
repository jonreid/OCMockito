//
//  OCMockito - MKTMockitoCore.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTClassMock;
@class MKTOngoingStubbing;
@protocol MKVerificationMode;


@interface MKTMockitoCore : NSObject

+ (id)sharedCore;

- (MKTOngoingStubbing *)stubAtLocation:(MKTTestLocation)location;

- (id)verifyMock:(MKTClassMock *)mock
        withMode:(id <MKVerificationMode>)mode
      atLocation:(MKTTestLocation)location;

@end
