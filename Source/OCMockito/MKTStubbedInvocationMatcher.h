//
//  OCMockito - MKTStubbedInvocationMatcher.h
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTInvocationMatcher.h"
#import "MKTExpectation.h"


@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher

@property (nonatomic, strong) id answer;
@property (nonatomic, strong) id<MKTExpectation> expectation;

@end
