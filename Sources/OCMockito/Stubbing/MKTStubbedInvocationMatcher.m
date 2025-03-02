// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTStubbedInvocationMatcher.h"


@interface MKTStubbedInvocationMatcher ()
@property (nonatomic, copy, readonly) NSMutableArray<id <MKTAnswer>> *answers;
@property (nonatomic, assign) NSUInteger index;
@end

@implementation MKTStubbedInvocationMatcher

- (instancetype)init
{
    self = [super init];
    if (self)
        _answers = [[NSMutableArray alloc] init];
    return self;
}

- (void)addAnswer:(id <MKTAnswer>)answer
{
    [self.answers addObject:answer];
}

- (nullable id)answerInvocation:(NSInvocation *)invocation
{
    id <MKTAnswer> a = self.answers[self.index];
    NSUInteger bumpedIndex = self.index + 1;
    if (bumpedIndex < self.answers.count)
        self.index = bumpedIndex;
    return [a answerInvocation:invocation];
}

@end
