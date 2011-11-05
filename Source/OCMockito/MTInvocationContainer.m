//
//  OCMockito - MTInvocationContainer.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationContainer.h"

#import "MTStubbedInvocationMatcher.h"


@interface MTInvocationContainer ()
@property(nonatomic, retain) MTMockingProgress *mockingProgress;
@property(nonatomic, retain) MTStubbedInvocationMatcher *invocationMatcherForStubbing;
@property(nonatomic, retain) NSMutableArray *stubbed;
@end


@implementation MTInvocationContainer

@synthesize registeredInvocations;
@synthesize mockingProgress;
@synthesize invocationMatcherForStubbing;
@synthesize stubbed;

- (id)initWithMockingProgress:(MTMockingProgress *)theMockingProgress
{
    self = [super init];
    if (self)
    {
        registeredInvocations = [[NSMutableArray alloc] init];
        mockingProgress = [theMockingProgress retain];
        stubbed = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [registeredInvocations release];
    [mockingProgress release];
    [invocationMatcherForStubbing release];
    [stubbed release];
    
    [super dealloc];
}

- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [invocation retainArguments];
    [registeredInvocations addObject:invocation];
    
    MTStubbedInvocationMatcher *stubbedInvocationMatcher = [[MTStubbedInvocationMatcher alloc] init];
    [stubbedInvocationMatcher setExpectedInvocation:invocation];
    [self setInvocationMatcherForStubbing:stubbedInvocationMatcher];
    [stubbedInvocationMatcher release];
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    [invocationMatcherForStubbing setMatcher:matcher atIndex:argumentIndex];
}

- (void)addAnswer:(id)answer
{
    [registeredInvocations removeLastObject];
    
    [invocationMatcherForStubbing setAnswer:answer];
    [stubbed insertObject:invocationMatcherForStubbing atIndex:0];
}

- (id)findAnswerFor:(NSInvocation *)invocation
{
    for (MTStubbedInvocationMatcher *stubbedInvocationMatcher in stubbed)
        if ([stubbedInvocationMatcher matches:invocation])
            return [stubbedInvocationMatcher answer];
    
    return nil;
}

@end
