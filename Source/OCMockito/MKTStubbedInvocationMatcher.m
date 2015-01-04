//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTStubbedInvocationMatcher.h"

#import "MKTReturns.h"


@interface MKTStubbedInvocationMatcher ()
@property (readonly, nonatomic, copy) NSMutableArray *answers;
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

- (void)addAnswer:(id)answer
{
    MKTReturns *returns = [[MKTReturns alloc] initWithAnswer:answer];
    [self.answers addObject:returns];
}

- (id)answer
{
    id <MKTAnswer> a = self.answers[self.index];
    NSUInteger bumpedIndex = self.index + 1;
    if (bumpedIndex < self.answers.count)
        self.index = bumpedIndex;
    return [a answer];
}

@end
