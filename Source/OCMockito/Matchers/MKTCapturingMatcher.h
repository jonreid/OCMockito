//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <OCHamcrest/HCIsAnything.h>


/*!
 * @deprecated Version 2.0.0 Use HCArgumentCaptor instead.
 */
__attribute__ ((deprecated))
@interface MKTCapturingMatcher : HCIsAnything

- (NSArray *)allValues;
- (id)lastValue;

@end
