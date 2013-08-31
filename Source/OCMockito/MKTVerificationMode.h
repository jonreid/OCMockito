//
//  OCMockito - MKTVerificationMode.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>

@class MKTVerificationData;
@class MKTVerificationModeResult;


@protocol MKTVerificationMode <NSObject>

- (void)verifyData:(MKTVerificationData *)data;

@end
