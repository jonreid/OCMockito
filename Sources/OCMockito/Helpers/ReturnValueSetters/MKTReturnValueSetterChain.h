// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>

@class MKTReturnValueSetter;


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Returns chain of return value handlers.
 */
FOUNDATION_EXPORT MKTReturnValueSetter *MKTReturnValueSetterChain(void);

NS_ASSUME_NONNULL_END
