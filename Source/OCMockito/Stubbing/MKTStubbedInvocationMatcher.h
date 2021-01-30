//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTInvocationMatcher.h"
#import "MKTAnswer.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher <MKTAnswer>

- (void)addAnswer:(id <MKTAnswer>)answer;

@end

NS_ASSUME_NONNULL_END
