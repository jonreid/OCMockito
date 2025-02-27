// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

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
