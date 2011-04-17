//
//  OCMockito - MTInvocationMatcher.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTInvocationMatcher.h"

#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MTInvocationMatcher ()
@property(nonatomic, retain) NSInvocation *invocation;
@end


@implementation MTInvocationMatcher

@synthesize invocation;


- (id)initWithExpectedInvocation:(NSInvocation *)expected
{
    self = [super init];
    if (self)
    {
        invocation = [expected retain];
        [invocation retainArguments];
    }
    return self;
}


- (void)dealloc
{
    [invocation release];
    [super dealloc];
}


- (BOOL)matches:(NSInvocation *)actual
{
    if ([invocation selector] != [actual selector])
        return NO;
    
    NSUInteger numberOfArguments = [[invocation methodSignature] numberOfArguments];
    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++argumentIndex)
    {
        id <HCMatcher> expectedArgument = nil;
        [invocation getArgument:&expectedArgument atIndex:argumentIndex];
        
        id actualArgument = nil;
        [actual getArgument:&actualArgument atIndex:argumentIndex];
        
        if (![expectedArgument matches:actualArgument])
            return NO;
    }
    
    return YES;
}

@end
