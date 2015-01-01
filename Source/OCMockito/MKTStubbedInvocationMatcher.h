//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationMatcher.h"
#import "MKTExpectation.h"


@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher

@property (nonatomic, strong) id answer;
@property (nonatomic, strong) id<MKTExpectation> expectation;

@end
