//
//  OCMockito - MTMockingProgress.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTTestLocation.h"

@protocol MTVerificationMode;


@interface MTMockingProgress : NSObject

@property(nonatomic, assign) MTTestLocation testLocation;

- (void)verification:(id <MTVerificationMode>)mode startedAtLocation:(MTTestLocation)location;
- (id <MTVerificationMode>)pullVerificationMode;

@end
