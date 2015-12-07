//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTMissingInvocationChecker.h"
#import "MKTInvocationsFinder.h"
#import "MKTInvocationMatcher.h"


@implementation MKTMissingInvocationChecker

- (NSString *)checkInvocations:(NSArray *)invocations wanted:(MKTInvocationMatcher *)wanted
{
    [self.invocationsFinder findInvocationsInList:invocations matching:wanted];
    return nil;
}

@end
