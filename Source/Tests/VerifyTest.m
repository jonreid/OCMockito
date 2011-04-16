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

- (void)testNotInvokingVoidMethodWithNoArgumentsShouldFailVerify
{
    // set up
    NSMutableArray *mockArray = [OCMockito mockForClass:[NSMutableArray class]];
    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
    
    // exercise
    [verifyWithMockTestCase(mockArray) removeAllObjects];
    
    // verify
    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
}


- (void)testInvokingVoidMethodWithNoArgumentsShouldPassVerify
{
    // set up
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    
    // exercise
    [mockArray removeAllObjects];
    
    // verify
    [verify(mockArray) removeAllObjects];
}


//- (void)testInvokingVoidMethodWithDifferentObjectArgumentShouldFailVerify
//{
//    // set up
//    NSMutableArray *mockArray = mock([NSMutableArray class]);
//    MockTestCase *mockTestCase = [[[MockTestCase alloc] init] autorelease];
//    
//    // exercise
//    [mockArray removeObject:@"foo"];
//    [verifyWithMockTestCase(mockArray) removeObject:@"bar"];
//
//    // verify
//    assertThatUnsignedInteger([mockTestCase failureCount], is(equalToUnsignedInteger(1)));    
//}
//
//
//- (void)testInvokingVoidMethodWithEqualObjectArgumentShouldPassVerify
//{
//    // set up
//    NSMutableArray *mockArray = mock([NSMutableArray class]);
//    id object1 = [NSString stringWithString:@"stub"];
//    id object2 = [NSString stringWithString:@"stub"];
//    
//    // exercise
//    [mockArray removeObject:object1];
//    
//    // verify
//    [verify(mockArray) removeObject:object2];
//}

@end
