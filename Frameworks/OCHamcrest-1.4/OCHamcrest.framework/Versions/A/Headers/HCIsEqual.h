//
//  OCHamcrest - HCIsEqual.h
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import <OCHamcrest/HCBaseMatcher.h>


/**
    Is the object equal to another object, as tested by the @c -isEqual: method?
 
    If the given object is @c nil, the matcher will match @c nil.
 
    @ingroup core_matchers
 */
@interface HCIsEqual : HCBaseMatcher
{
    id object;
}

+ (id)isEqualTo:(id)anObject;
- (id)initEqualTo:(id)anObject;

@end

//--------------------------------------------------------------------------------------------------

/**
    Is the object equal to another object, as tested by the @c -isEqual: method?
 
    If the given object is @c nil, the matcher will match @c nil.
 
    @b Synonym: @ref equalTo
    @see HCIsEqual
    @ingroup core_matchers
 */
OBJC_EXPORT id<HCMatcher> HC_equalTo(id object);

/**
    equalTo(object) -
    Is the object equal to another object, as tested by the @c -isEqual: method?

    If the given object is @c nil, the matcher will match @c nil.

    Synonym for @ref HC_equalTo, available if @c HC_SHORTHAND is defined.
    @see HCIsEqual
    @ingroup core_matchers
 */
#ifdef HC_SHORTHAND
    #define equalTo HC_equalTo
#endif
