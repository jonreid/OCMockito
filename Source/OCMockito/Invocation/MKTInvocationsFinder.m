//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"

#import "MKTInvocationMatcher.h"


@implementation MKTInvocationsFinder

+ (NSArray *)findInvocationsInList:(NSArray *)array matching:(MKTInvocationMatcher *)wanted
{
    return [array filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(id invocation, NSDictionary *bindings) {
                return [wanted matches:invocation];
            }]];
}

@end
