//
//  OCMockito - MTClassMock.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTClassMock.h"

#import "MTMockingProgress.h"
#import "MTMockitoCore.h"

@interface MTClassMock ()
@property(nonatomic, assign) Class mockedClass;
@property(nonatomic, assign) id testCase;
@end


@implementation MTClassMock

@synthesize mockedClass;
@synthesize testCase;


+ (id)mockForClass:(Class)aClass testCase:(id)test
{
    return [[[self alloc] initWithClass:aClass testCase:test] autorelease];
}


- (id)initWithClass:(Class)aClass testCase:(id)test
{
    if (self)
    {
        mockedClass = aClass;
        testCase = test;
    }
    return self;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    MTMockingProgress *mockingProgress = [[MTMockitoCore sharedCore] mockingProgress];
    id <MTVerificationMode> verificationMode = [mockingProgress pullVerificationMode];
    if (verificationMode)
    {
        
    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [mockedClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark -
#pragma mark NSObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [mockedClass instancesRespondToSelector:aSelector];
}

@end
