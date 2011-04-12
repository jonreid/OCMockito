//
//  OCMockito - MTVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MTVerificationData;


@protocol MTVerificationMode <NSObject>

- (void)verifyData:(MTVerificationData *)data;

@end
