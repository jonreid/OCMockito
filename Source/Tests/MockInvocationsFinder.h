//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationsFinder.h"


@interface MockInvocationsFinder : MKTInvocationsFinder

@property (nonatomic, copy) NSArray *capturedInvocations;
@property (nonatomic, strong) MKTInvocationMatcher *capturedWanted;
@property (nonatomic, assign) NSUInteger stubbedCount;
@property (nonatomic, assign) NSUInteger capturedInvocationIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfInvocationAtIndex;
@property (nonatomic, copy) NSArray *stubbedCallStackOfLastInvocation;

@end
