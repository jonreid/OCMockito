//
//  OCMockito - MTInvocationContainer.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationContainer.h"


@implementation MTInvocationContainer

@synthesize registeredInvocations;

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
    [super dealloc];
}


- (void)registerInvocation:(NSInvocation *)invocation
{
    [registeredInvocations addObject:invocation];
}

@end
