//
//  OCMockito - MTInvocationContainer.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationContainer.h"


@interface MTInvocationContainer ()
@property(nonatomic, retain) MTMockingProgress *mockingProgress;
@property(nonatomic, retain) NSInvocation *invocationForStubbing;
@end


@implementation MTInvocationContainer

@synthesize registeredInvocations;
@synthesize answer;
@synthesize mockingProgress;
@synthesize invocationForStubbing;


- (id)initWithMockingProgress:(MTMockingProgress *)theMockingProgress
{
    self = [super init];
    if (self)
    {
        registeredInvocations = [[NSMutableArray alloc] init];
        mockingProgress = [theMockingProgress retain];
    }
    return self;
}


- (void)dealloc
{
    [registeredInvocations release];
    [answer release];
    [mockingProgress release];
    [invocationForStubbing release];
    [super dealloc];
}


- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [invocation retainArguments];
    [registeredInvocations addObject:invocation];
    [self setInvocationForStubbing:invocation];
}


- (void)addAnswer:(id)object
{
    [registeredInvocations removeLastObject];
    [self setAnswer:object];
}

@end
