//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"

#import "MKTInvocationMatcher.h"


@interface MKTInvocationsFinder ()
@property (nonatomic, copy) NSArray *invocations;
@end

@implementation MKTInvocationsFinder

+ (MKTInvocationsFinder *)findInvocationsInList:(NSArray *)array matching:(MKTInvocationMatcher *)wanted
{
    MKTInvocationsFinder *finder = [[MKTInvocationsFinder alloc] init];
    finder.invocations = [array filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(id invocation, NSDictionary *bindings) {
                return [wanted matches:invocation];
            }]];
    return finder;
}

@end
