//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>
#import "MKTTestLocation.h"

@class MKTVerificationData;


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Allows verifying that certain behavior happened at least once / exact number of times /
 * never.
 */
@protocol MKTVerificationMode <NSObject>

- (void)verifyData:(MKTVerificationData *)data testLocation:(MKTTestLocation)testLocation;

@end

NS_ASSUME_NONNULL_END
