//
//  OCHamcrest - HCIsIn.h
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import <OCHamcrestIOS/HCBaseMatcher.h>


/**
    Is the object present in the given collection?
    @ingroup collection_matchers
 */
@interface HCIsIn : HCBaseMatcher
{
    id collection;
}

+ (id)isInCollection:(id)aCollection;
- (id)initWithCollection:(id)aCollection;

@end

//--------------------------------------------------------------------------------------------------

/**
    Is the object present in the given collection?
 
    @b Synonym: @ref isIn
    @see HCIsIn
    @ingroup collection_matchers
 */
OBJC_EXPORT id<HCMatcher> HC_isIn(id aCollection);

/**
    isIn(collection) -
    Is the object present in the given collection?

    Synonym for @ref HC_isIn, available if @c HC_SHORTHAND is defined.
    @see HCIsIn
    @ingroup collection_matchers
 */
#ifdef HC_SHORTHAND
    #define isIn  HC_isIn
#endif
