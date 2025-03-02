// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Chain-of-responsibility for converting objects to NSInvocation return values.
 */
@interface MKTReturnValueSetter : NSObject

/*!
 * @abstract Initializes a newly allocated return value setter.
 * @param handlerType Return type managed by this setter. Assign with \@encode compiler directive.
 * @param successor Successor in chain to handle return type.
 */
- (instancetype)initWithType:(char const *)handlerType successor:(nullable MKTReturnValueSetter *)successor NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
;

/*!
 * @abstract Set NSInvocation return value of specified type, or pass to successor.
 */
- (void)setReturnValue:(nullable id)returnValue ofType:(char const *)type onInvocation:(NSInvocation *)invocation;

@end

NS_ASSUME_NONNULL_END
