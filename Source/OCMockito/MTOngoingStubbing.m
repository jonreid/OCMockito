//
//  OCMockito - MTOngoingStubbing.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTOngoingStubbing.h"

#import "MTInvocationContainer.h"


@interface MTOngoingStubbing ()
@property(nonatomic, retain) MTInvocationContainer *invocationContainer;
@end


@implementation MTOngoingStubbing

@synthesize invocationContainer;


- (id)initWithInvocationContainer:(MTInvocationContainer *)anInvocationContainer
{
    self = [super init];
    if (self)
        invocationContainer = [anInvocationContainer retain];
    return self;
}


- (void)dealloc
{
    [invocationContainer release];
    [super dealloc];
}


- (MTOngoingStubbing *)willReturn:(id)object
{
    [invocationContainer addAnswer:object];
    return self;
}

@end
