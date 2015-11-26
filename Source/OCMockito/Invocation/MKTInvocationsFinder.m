//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"

#import "MKTInvocation.h"
#import "MKTInvocationMatcher.h"


@interface MKTInvocationsFinder ()
@property (nonatomic, copy) NSArray *invocations;
@end

@implementation MKTInvocationsFinder

@dynamic count;

+ (MKTInvocationsFinder *)findInvocationsInList:(NSArray *)invocations
                                       matching:(MKTInvocationMatcher *)wanted
{
    MKTInvocationsFinder *finder = [[MKTInvocationsFinder alloc] init];
    finder.invocations = [invocations filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(id obj, NSDictionary *bindings) {
                MKTInvocation *invocation = obj;
                return [wanted matches:invocation.invocation];
            }]];
    return finder;
}

- (NSUInteger)count
{
    return self.invocations.count;
}

@end
