//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

@protocol HCMatcher;


/*!
 * @abstract Ability to specify OCHamcrest matchers for primitive numeric arguments.
 */
@protocol MKTPrimitiveArgumentMatching

/*!
 * @abstract Specifies OCHamcrest matcher for a specific argument of a method.
 * @discussion For methods arguments that take objects, just pass the matcher directly as a method
 * call. But for arguments that take primitive numeric types, call this to specify the matcher
 * before passing in a dummy value. Upon verification, the actual numeric argument received will be
 * converted to an NSNumber before being checked by the matcher.
 *
 * The argument index is 0-based, so the first argument of a method has index 0.
 *
 * Example:
 * <ul>
 *   <li><code>[[verify(mockArray) withMatcher:greaterThan([NSNumber numberWithInt:1]) forArgument:0] removeObjectAtIndex:0];</code></li>
 * </ul>
 * This verifies that <code>removeObjectAtIndex:</code> was called with a number greater than 1.
 */
- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index;

/*!
 * @abstract Specifies OCHamcrest matcher for the first argument of a method.
 * @discussion Equivalent to <code>withMatcher:matcher forArgument:0</code>.
 *
 * Example:
 * <ul>
 *   <li><code>[[verify(mockArray) withMatcher:greaterThan([NSNumber numberWithInt:1])] removeObjectAtIndex:0];</code></li>
 * </ul>
 * This verifies that <code>removeObjectAtIndex:</code> was called with a number greater than 1.
*/
- (id)withMatcher:(id <HCMatcher>)matcher;

@end
