//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTReturnValueSetter;


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Returns chain of return value handlers.
 */
FOUNDATION_EXPORT MKTReturnValueSetter *MKTReturnValueSetterChain(void);

NS_ASSUME_NONNULL_END
