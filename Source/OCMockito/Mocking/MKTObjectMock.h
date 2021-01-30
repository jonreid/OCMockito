//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTBaseMockObject.h"


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Mock object of a given class.
 */
@interface MKTObjectMock : MKTBaseMockObject

- (instancetype)initWithClass:(Class)aClass NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
