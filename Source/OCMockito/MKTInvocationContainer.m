//
//  OCMockito - MKTInvocationContainer.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTInvocationContainer.h"

#import "MKTMockingProgress.h"
#import "MKTStubbedInvocationMatcher.h"


@implementation MKTInvocationContainer
{
    MKTStubbedInvocationMatcher *_invocationMatcherForStubbing;
    NSMutableArray *_stubbed;
    NSMutableArray *_answersForStubbing;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _registeredInvocations = [[NSMutableArray alloc] init];
        _stubbed = [[NSMutableArray alloc] init];
        _answersForStubbing = [[NSMutableArray  alloc] init];
    }
    return self;
}


- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [invocation retainArguments];
    [_registeredInvocations addObject:invocation];
    
    MKTStubbedInvocationMatcher *s = [[MKTStubbedInvocationMatcher alloc] init];
    [s setExpectedInvocation:invocation];
    _invocationMatcherForStubbing = s;
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    [_invocationMatcherForStubbing setMatcher:matcher atIndex:argumentIndex];
}

- (void)addAnswer:(id)answer
{
    [_registeredInvocations removeLastObject];
    
    [_invocationMatcherForStubbing setAnswer:answer];
    [_stubbed insertObject:_invocationMatcherForStubbing atIndex:0];
}

- (MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation
{
    for (MKTStubbedInvocationMatcher *s in _stubbed)
        if ([s matches:invocation])
            return s;
    return nil;
}

- (void)setAnswersForStubbing:(NSArray *)answers
{
    [_answersForStubbing addObjectsFromArray:answers];
}

- (BOOL)hasAnswersForStubbing
{
    return [_answersForStubbing count] != 0;
}
@end
