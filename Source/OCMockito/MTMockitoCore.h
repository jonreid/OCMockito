//
//  OCMockito - MTMockitoCore.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTTestLocation.h"

@class MTClassMock;
@class MTMockingProgress;
@protocol MTVerificationMode;


@interface MTMockitoCore : NSObject

@property(nonatomic, retain) MTMockingProgress *mockingProgress;

+ (id)sharedCore;

- (id)verifyMock:(MTClassMock *)mock
        withMode:(id <MTVerificationMode>)mode
      atLocation:(MTTestLocation)location;

@end
