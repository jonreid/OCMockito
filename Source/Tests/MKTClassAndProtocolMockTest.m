//
//  MKTClassAndProtocolMockTest.m
//  OCMockito
//
//  Created by Kevin Lundberg on 3/14/12.
//  Copyright (c) 2012 Kevin Lundberg. All rights reserved.
//
#define MOCKITO_SHORTHAND
#import "OCMockito.h"

#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
#import <OCHamcrest/OCHamcrest.h>
#else
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@protocol TestProtocol <NSObject>

@required
- (void) requiredMethod;

@end

@interface TestClass : NSObject 

- (void) instanceMethod;

@end

@implementation TestClass

- (void) instanceMethod
{
    
}

@end

@interface TestSubclass : TestClass <TestProtocol>

@end

@implementation TestSubclass

- (void) requiredMethod
{
    
}

@end


#pragma mark -

@interface MKTClassAndProtocolMockTest : SenTestCase

@end


@implementation MKTClassAndProtocolMockTest

- (void)testClassProtocolMockCanCallMethodFromClass
{
    // given
    TestClass<TestProtocol> *obj = mockClassAndProtocol([TestClass class], @protocol(TestProtocol));
    
    // then
    STAssertNoThrow([obj instanceMethod],nil);
}

- (void)testClassProtocolMockCanCallMethodFromProtocol
{
    // given
    TestClass<TestProtocol> *obj = mockClassAndProtocol([TestClass class], @protocol(TestProtocol));
    
    // then
    STAssertNoThrow([obj requiredMethod],nil);
}

@end
