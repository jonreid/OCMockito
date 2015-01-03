//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt

#import "MKTStubbedInvocationMatcher.h"


@interface MKTStubbedInvocationMatcher ()
@property (nonatomic, strong) id answers;
@end

@implementation MKTStubbedInvocationMatcher

- (void)addAnswer:(id)answer
{
    self.answers = answer;
}

- (id)answer
{
    return self.answers;
}

@end
