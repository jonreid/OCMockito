//
//  OCMockito - MKVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MKVerificationData;


@protocol MKVerificationMode <NSObject>

- (void)verifyData:(MKVerificationData *)data;

@end
