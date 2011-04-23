//
//  OCMockito - MTInvocationContainer.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationContainer.h"

#import "MTStubbedInvocationMatcher.h"


@interface MTInvocationContainer ()
@property(nonatomic, retain) MTMockingProgress *mockingProgress;
@property(nonatomic, retain) NSInvocation *invocationForStubbing;
@property(nonatomic, retain) NSMutableArray *stubbed;
@end


@implementation MTInvocationContainer

@synthesize registeredInvocations;
@synthesize mockingProgress;
@synthesize invocationForStubbing;
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
    [invocationForStubbing release];
    [stubbed release];
    
    [super dealloc];
}


- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [invocation retainArguments];
    [registeredInvocations addObject:invocation];
    [self setInvocationForStubbing:invocation];
}


- (void)addAnswer:(id)answer
{
    [registeredInvocations removeLastObject];
    
    MTStubbedInvocationMatcher *stubbedInvocationMatcher = [[MTStubbedInvocationMatcher alloc] init];
    [stubbedInvocationMatcher setExpectedInvocation:invocationForStubbing];
    [stubbedInvocationMatcher setAnswer:answer];
    [stubbed insertObject:stubbedInvocationMatcher atIndex:0];
    [stubbedInvocationMatcher release];
}


- (id)findAnswerFor:(NSInvocation *)invocation
{
    for (MTStubbedInvocationMatcher *stubbedInvocationMatcher in stubbed)
        if ([stubbedInvocationMatcher matches:invocation])
            return [stubbedInvocationMatcher answer];
    
    return nil;
}

@end
