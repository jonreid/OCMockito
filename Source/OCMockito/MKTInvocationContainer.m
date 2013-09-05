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
    MKTStubbedInvocationMatcher *_invocationForStubbing;
    NSMutableArray *_stubbed;
    NSMutableArray *_answersForStubbing;
}

- (instancetype)init
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
    _invocationForStubbing = s;
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    [_invocationForStubbing setMatcher:matcher atIndex:argumentIndex];
}

- (void)addAnswer:(id)answer
{
    [_registeredInvocations removeLastObject];

    [_invocationForStubbing setAnswer:answer];
    [_stubbed insertObject:_invocationForStubbing atIndex:0];
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

- (void)setMethodForStubbing:(MKTInvocationMatcher *)invocationMatcher
{
    _invocationForStubbing = [[MKTStubbedInvocationMatcher alloc] initCopyingInvocationMatcher:invocationMatcher];
    for (id answer in _answersForStubbing)
        [self addAnswer:answer];
    [_answersForStubbing removeAllObjects];
}

@end
