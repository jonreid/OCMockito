//
//  OCMockito - MKTCapturingMatcher.h
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <OCHamcrest/HCIsAnything.h>


@interface MKTCapturingMatcher : HCIsAnything

- (void)captureArgument:(id)arg;
- (NSArray *)allValues;
- (id)lastValue;

@end
