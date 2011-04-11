//
//  OCMockito - MTClassMock.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTClassMock.h"

@interface MTClassMock ()
@property(nonatomic, assign) Class mockedClass;
@property(nonatomic, assign) id testCase;
- (id)initWithClass:(Class)aClass testCase:(id)test;
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
