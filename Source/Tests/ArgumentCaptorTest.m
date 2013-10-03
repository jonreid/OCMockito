//
//  OCMockito - ArgumentCaptorTest.m
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#define MOCKITO_SHORTHAND
#import "OCMockito.h"
#import "MKTArgumentCaptor.h"

// Test support
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#if TARGET_OS_MAC
    #import <OCHamcrest/OCHamcrest.h>
#else
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif


@interface ArgumentCaptorTest : SenTestCase
@end

@implementation ArgumentCaptorTest

//- (void)testArgumentCaptor_ShouldCaptureValue
//{
//    MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];
//    NSMutableArray *mockArray = mock([NSMutableArray class]);
//    [mockArray addObject:@"FOO"];
//    [verify(mockArray) addObject:[argument capture]];
//    assertThat([argument value], is(@"FOO"));
//}

@end
