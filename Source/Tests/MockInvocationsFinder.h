// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTMatchingInvocationsFinder.h"


@interface MockInvocationsFinder : MKTMatchingInvocationsFinder

@property (nonatomic, copy) NSArray<MKTInvocation *> *capturedInvocations;
@property (nonatomic, strong) MKTInvocationMatcher *capturedWanted;
@property (nonatomic, assign) NSUInteger stubbedCount;
@property (nonatomic, assign) NSUInteger capturedInvocationIndex;
@property (nonatomic, strong) MKTLocation *stubbedLocationOfInvocationAtIndex;
@property (nonatomic, strong) MKTLocation *stubbedLocationOfLastInvocation;
@end
