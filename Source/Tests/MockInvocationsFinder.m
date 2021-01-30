//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MockInvocationsFinder.h"


@implementation MockInvocationsFinder

- (void)findInvocationsInList:(NSArray<MKTInvocation *> *)invocations matching:(MKTInvocationMatcher *)wanted
{
    self.capturedInvocations = invocations;
    self.capturedWanted = wanted;
}

- (NSUInteger)count
{
    return self.stubbedCount;
}

- (MKTLocation *)locationOfInvocationAtIndex:(NSUInteger)index
{
    self.capturedInvocationIndex = index;
    return self.stubbedLocationOfInvocationAtIndex;
}

- (MKTLocation *)locationOfLastInvocation
{
    return self.stubbedLocationOfLastInvocation;
}

@end
