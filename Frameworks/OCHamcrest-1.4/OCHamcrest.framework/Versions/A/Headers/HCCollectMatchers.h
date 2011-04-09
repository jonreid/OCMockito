//
//  OCHamcrest - HCCollectMatchers.h
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

#import <Foundation/Foundation.h>
#import <objc/objc-api.h>

    // C
#import <stdarg.h>

@protocol HCMatcher;


/**
    Returns an array of matchers from a variable-length comma-separated list terminated by @c nil.
    @ingroup helpers
*/
OBJC_EXPORT NSMutableArray *HCCollectMatchers(id<HCMatcher> matcher1, va_list args);
