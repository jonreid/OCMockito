//
//  OCHamcrest - HCIsEmptyCollection.h
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import <OCHamcrest/HCHasCount.h>


/**
    Matches empty collection.
    @ingroup collection_matchers
 */
@interface HCIsEmptyCollection : HCHasCount

+ (id)isEmptyCollection;
- (id)init;

@end

//--------------------------------------------------------------------------------------------------

/**
    Matches empty collection.
 
    @b Synonym: @ref empty
    @see HCIsEmptyCollection
    @ingroup collection_matchers
 */
OBJC_EXPORT id<HCMatcher> HC_empty();

/**
    Matches empty collection.

    Synonym for @ref HC_empty, available if @c HC_SHORTHAND is defined.
    @see HCIsEmptyCollection
    @ingroup collection_matchers
 */
#ifdef HC_SHORTHAND
    #define empty()  HC_empty()
#endif
