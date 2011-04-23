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


#define verifyWithMockTestCase(mock) MTVerifyWithLocation(mock, mockTestCase, __FILE__, __LINE__)


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

- (void)testInvokingMethodWithNoArgumentsShouldPassVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeAllObjects];
    
    [verify(mockArray) removeAllObjects];
}


- (void)testNotInvokingMethodWithNoArgumentsShouldFailVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    [verifyWithMockTestCase(mockArray) removeAllObjects];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}


- (void)testInvokingWithEqualObjectArgumentsShouldPassVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeObject:@"same"];
    
    [verify(mockArray) removeObject:@"same"];
}


- (void)testInvokingWithDifferentObjectArgumentsShouldFailVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    [mockArray removeObject:@"same"];
    
    [verifyWithMockTestCase(mockArray) removeObject:@"different"];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}


- (void)testInvokingWithArgumentMatcherSatisfiedShouldPassVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeObject:@"same"];

    [verify(mockArray) removeObject:equalTo(@"same")];
}


- (void)testInvokingWithEqualPrimitiveNumericArgumentsShouldPassVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeObjectAtIndex:2];
    
    [verify(mockArray) removeObjectAtIndex:2];
}


- (void)testInvokingWithDifferentPrimitiveNumericArgumentsShouldFailVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    [mockArray removeObjectAtIndex:2];
    
    [verifyWithMockTestCase(mockArray) removeObjectAtIndex:99];
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}


- (void)testMatcherSatisfiedWithNumericArgumentShouldPassVerify
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeObjectAtIndex:2];
    
    [[verify(mockArray) setMatcher:greaterThan([NSNumber numberWithInt:1]) atIndex:0]
     removeObjectAtIndex:0];
}


- (void)testShortcutForSpecifyingMatcherForFirstArgument
{
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    [mockArray removeObjectAtIndex:2];
    
    [[verify(mockArray) withMatcher:greaterThan([NSNumber numberWithInt:1])] removeObjectAtIndex:0];
}


@end
