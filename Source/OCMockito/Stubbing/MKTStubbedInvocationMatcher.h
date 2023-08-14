// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTInvocationMatcher.h"
#import "MKTAnswer.h"


NS_ASSUME_NONNULL_BEGIN

@interface MKTStubbedInvocationMatcher : MKTInvocationMatcher <MKTAnswer>

- (void)addAnswer:(id <MKTAnswer>)answer;

@end

NS_ASSUME_NONNULL_END
