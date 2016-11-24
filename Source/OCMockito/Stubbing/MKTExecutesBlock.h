//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "MKTAnswer.h"

/*!
 * @abstract Method answer that executes a block.
 */
@interface MKTExecutesBlock : NSObject <MKTAnswer>

- (instancetype)initWithBlock:(id (^)(NSInvocation *))block NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end
