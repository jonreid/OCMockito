//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTMatchingInvocationsFinder.h"


@interface MockInvocationsFinder : MKTMatchingInvocationsFinder

@property (nonatomic, copy) NSArray<MKTInvocation *> *capturedInvocations;
@property (nonatomic, strong) MKTInvocationMatcher *capturedWanted;
@property (nonatomic, assign) NSUInteger stubbedCount;
@property (nonatomic, assign) NSUInteger capturedInvocationIndex;
@property (nonatomic, strong) MKTLocation *stubbedLocationOfInvocationAtIndex;
@property (nonatomic, strong) MKTLocation *stubbedLocationOfLastInvocation;
@end
