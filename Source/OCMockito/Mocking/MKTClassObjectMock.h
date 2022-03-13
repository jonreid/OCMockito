// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by David Hart

#import <OCMockito/MKTBaseMockObject.h>


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Mock object of a given class object.
 */
@interface MKTClassObjectMock : MKTBaseMockObject

@property (nonatomic, strong, readonly) Class mockedClass;

- (instancetype)initWithClass:(Class)aClass NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;

@end

NS_ASSUME_NONNULL_END
