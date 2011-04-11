//
//  OCMockito - MTVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@protocol MTVerificationData;


@protocol MTVerificationMode <NSObject>

- (void)verifyWithData:(id <MTVerificationData>)data;

@end
