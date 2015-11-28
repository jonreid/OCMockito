//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MockInvocationsFinder.h"


@implementation MockInvocationsFinder

- (void)findInvocationsInList:(NSArray *)invocations matching:(MKTInvocationMatcher *)wanted
{
    self.capturedInvocations = invocations;
    self.capturedWanted = wanted;
}

- (NSUInteger)count
{
    return self.stubbedCount;
}

- (NSArray *)callStackOfInvocationAtIndex:(NSUInteger)index
{
    self.capturedInvocationIndex = index;
    return self.stubbedCallStackOfInvocationAtIndex;
}

- (NSArray *)callStackOfLastInvocation
{
    return self.stubbedCallStackOfLastInvocation;
}

@end
