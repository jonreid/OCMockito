//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>

@class MKTInvocationMatcher;


@interface MKTInvocationsFinder : NSObject

+ (MKTInvocationsFinder *)findInvocationsInList:(NSArray *)array matching:(MKTInvocationMatcher *)wanted;

@end
