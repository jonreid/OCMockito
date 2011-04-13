//
//  OCMockito - VerifyTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

	// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MockTestCase : NSObject
@property(nonatomic, assign) NSUInteger failureCount;
@property(nonatomic, retain) NSException *failureException;
- (void)failWithException:(NSException *)exception;
@end

@implementation MockTestCase
@synthesize failureCount;
@synthesize failureException;

- (void)dealloc
{
    [failureException release];
    [super dealloc];
}

- (void)failWithException:(NSException *)exception
{
    ++failureCount;
    [self setFailureException:exception];
}

@end


#pragma mark -

@interface VerifyTest : SenTestCase
@end


@implementation VerifyTest

- (void)testInvokingVoidMethodWithNoArgsShouldVerify
{
    // set up
    NSMutableArray *mockArray = mockForClass([NSMutableArray class]);
    
    // exercise
    [mockArray removeAllObjects];
    
    // verify
    [verify(mockArray) removeAllObjects];
}


- (void)testNotInvokingVoidMethodWithNoArgsVerifyShouldFail
{
    // set up
    MockTestCase *testCase = [[[MockTestCase alloc] init] autorelease];
    NSMutableArray *mockArray = [OCMockito mockForClass:[NSMutableArray class]];
        
    // exercise
    [MTVerifyWithLocation(mockArray, testCase, __FILE__, __LINE__) removeAllObjects];
    
    // verify
    assertThatUnsignedInteger([testCase failureCount], is(equalToUnsignedInteger(1)));    
}

@end
