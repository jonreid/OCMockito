//
//  OCMockito - MTInvocationContainer.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationContainer.h"


@interface MTInvocationContainer ()
@property(nonatomic, retain) NSInvocation *invocationForStubbing;
@end


@implementation MTInvocationContainer

@synthesize registeredInvocations;
@synthesize invocationForStubbing;


- (id)init
{
    self = [super init];
    if (self)
        registeredInvocations = [[NSMutableArray alloc] init];
    return self;
}


- (void)dealloc
{
    [registeredInvocations release];
    [invocationForStubbing release];
    [super dealloc];
}


- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [registeredInvocations addObject:invocation];
    [self setInvocationForStubbing:invocation];
}

@end
