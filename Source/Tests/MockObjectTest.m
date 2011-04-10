//
//  OCMockito - MockObjectTest.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

	// Class under test
#import "MTMockObject.h"

	// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface MockObjectTest : SenTestCase
@end


@implementation MockObjectTest

- (void)testNameOfTest
{
	// set up

	// exercise

	// verify
	STFail(@"Test runs successfully", nil);
}

@end
