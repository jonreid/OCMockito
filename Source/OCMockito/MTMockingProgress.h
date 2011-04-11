//
//  OCMockito - MTMockingProgress.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTLineLocation.h"

@protocol MTVerificationMode;


@interface MTMockingProgress : NSObject

- (void)verificationStarted:(id <MTVerificationMode>)mode lineLocation:(MTLineLocation)location;
- (id <MTVerificationMode>)pullVerificationMode;

@end
