//
//  OCMockito - MKVerificationMode.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

@class MKTVerificationData;


@protocol MKVerificationMode <NSObject>

- (void)verifyData:(MKTVerificationData *)data;

@end
