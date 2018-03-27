//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import "MKTAnswer.h"


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Method answer that throws an exception.
 */
@interface MKTThrowsException : NSObject <MKTAnswer>

- (instancetype)initWithException:(NSException *)exception NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
