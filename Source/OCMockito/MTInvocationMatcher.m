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
@property(nonatomic, assign) NSUInteger numberOfArguments;
@end


@implementation MTInvocationMatcher

@synthesize invocation;
@synthesize numberOfArguments;


- (void)dealloc
{
    [invocation release];
    [super dealloc];
}


- (void)setExpected:(NSInvocation *)expected
{
    [self setInvocation:expected];
    
    numberOfArguments = [[invocation methodSignature] numberOfArguments];
    for (NSUInteger argumentIndex = 2; argumentIndex < numberOfArguments; ++argumentIndex)
    {
        id argument = nil;
        [invocation getArgument:&argument atIndex:argumentIndex];
        
        if (![argument conformsToProtocol:@protocol(HCMatcher)])
        {
            HCIsEqual *isEqualMatcher = [[[HCIsEqual alloc] initEqualTo:argument] autorelease];
            [invocation setArgument:&isEqualMatcher atIndex:argumentIndex];
        }
    }
    
    [invocation retainArguments];
}


- (BOOL)matches:(NSInvocation *)actual
{
    if ([invocation selector] != [actual selector])
        return NO;
    
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
