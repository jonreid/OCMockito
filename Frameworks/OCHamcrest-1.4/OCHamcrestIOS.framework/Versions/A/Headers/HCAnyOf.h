//
//  OCHamcrest - HCAnyOf.h
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import <OCHamcrestIOS/HCBaseMatcher.h>


/**
    Calculates the logical disjunction of multiple matchers.

    Evaluation is shortcut, so the subsequent matchers are not called if an earlier matcher returns
    @c YES.

    @ingroup core_matchers
 */
@interface HCAnyOf : HCBaseMatcher
{
    NSArray *matchers;
}

+ (id)anyOf:(NSArray *)theMatchers;
- (id)initWithMatchers:(NSArray *)theMatchers;

@end

//--------------------------------------------------------------------------------------------------

/**
    Evaluates to @c YES if @em any of the given matchers evaluate to @c YES.
 
    @b Synonym: @ref anyOf
    @param matcher1  Comma-separated list of matchers ending with @c nil.
    @see HCAnyOf
    @ingroup core_matchers
 */
OBJC_EXPORT id<HCMatcher> HC_anyOf(id<HCMatcher> matcher1, ...);

/**
    anyOf(matcher1, ...) -
    Evaluates to @c YES if @em any of the given matchers evaluate to @c YES.
 
    Synonym for @ref HC_anyOf, available if @c HC_SHORTHAND is defined.
    @param matcher1  Comma-separated list of matchers ending with @c nil.
    @see HCAnyOf
    @ingroup core_matchers
 */
#ifdef HC_SHORTHAND
    #define anyOf HC_anyOf
#endif
