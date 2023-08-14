// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT
//  Contribution by Igor Sales

#import <Foundation/Foundation.h>

@class MKTClassObjectMock;


NS_ASSUME_NONNULL_BEGIN

@interface MKTSingletonSwizzler : NSObject

- (instancetype)initWithMock:(MKTClassObjectMock *)classMock NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)swizzleSingletonAtSelector:(SEL)singletonSelector;
- (void)unswizzleSingletonsForMock;

@end

NS_ASSUME_NONNULL_END
