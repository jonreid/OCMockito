//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

#import "MKTTestLocation.h"

@class MKTObjectMock;
@class MKTOngoingStubbing;
@protocol MKTVerificationMode;


NS_ASSUME_NONNULL_BEGIN

@interface MKTMockitoCore : NSObject

+ (instancetype)sharedCore;

- (MKTOngoingStubbing *)stubAtLocation:(MKTTestLocation)location;

- (id)verifyMock:(MKTObjectMock *)mock
        withMode:(id <MKTVerificationMode>)mode
      atLocation:(MKTTestLocation)location;

@end

NS_ASSUME_NONNULL_END
