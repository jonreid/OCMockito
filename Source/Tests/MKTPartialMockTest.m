//
//  MKTPartialMockTest.m
//  OCMockito
//
//  Created by Erik Blomqvist on 2013-10-20.
//  Copyright (c) 2013 Erik Blomqvist. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

#define HC_SHORTHAND
#if TARGET_OS_MAC
#import <OCHamcrest/OCHamcrest.h>
#else
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#endif

@interface Example : NSObject

@property (nonatomic) NSUInteger methodACount;
@property (nonatomic) NSUInteger methodBCount;
@property (nonatomic) NSUInteger methodCCount;

- (NSString *)methodA;
- (NSString *)methodB;
- (void)methodC;

@end

@implementation Example

- (NSString *)methodA {
    self.methodACount++;
    [self methodB];
    return @"methodA";
}
- (NSString *)methodB {
    self.methodBCount++;
    return @"methodB";
}

- (void)methodC {
    self.methodCCount++;
    [self methodA];
}

@end

@interface MKTPartialMockTest : SenTestCase

@end

@implementation MKTPartialMockTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatExampleClassWorksAsExpected {
    // given
    Example *example = [Example new];
    
    // when
    [example methodA];
    [example methodB];
    
    // then
    assertThatUnsignedInteger(example.methodACount, is(equalToUnsignedInteger(1)));
    assertThatUnsignedInteger(example.methodBCount, is(equalToUnsignedInteger(2)));
}

- (void)testThatSpyObjectCanBeStubbedJustLikeAnyOtherMock
{
    NSArray *array = @[@1, @2, @3];
    id spy = spy(array);
    [given([spy objectAtIndex:0]) willReturn:@"foo"];
    [spy disguise];
    assertThat([spy objectAtIndex:0], is(@"foo"));
}

- (void)testThatSpyObjectStubbsAreArgumentSensitive
{
    NSArray *array = @[@1, @2, @3];
    id spy = spy(array);
    [given([spy objectAtIndex:0]) willReturn:@"foo"];
    [spy disguise];
    assertThat([spy objectAtIndex:1], is(@2));
}

- (void)testStubbingVoidMethod
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    
    // [given([spy methodC]) willDoNothing];
    // Will give the following error:
    // Argument type 'void' is incomplete
    // The following works the same, but is not as pretty:
    [spy methodC];
    [given(nil) willDoNothing];
    [spy disguise];
    
    // when
    [spy methodC];
    
    //then
    [verifyCount(spy, times(0)) methodA];
    [verifyCount(spy, times(0)) methodB];
    [verifyCount(spy, times(1)) methodC];

}

- (void)testThatVerficationOfNonStubbedMethodsWorks
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    [given([spy methodB]) willReturn:@"foo"];
    [spy disguise];
    
    // when
    [spy methodA];
    
    // then
    [verify(spy) methodA];
}

- (void)testThatVerficationOfStubbedMethodsWorks
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    [given([spy methodB]) willReturn:@"foo"];
    [spy disguise];
    
    // when
    [spy methodB];
    
    // then
    [verify(spy) methodB];
}

- (void)testThatVerficationOfNonStubbedMethodsWorksForDirectCalls
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    [given([spy methodB]) willReturn:@"foo"];
    [spy disguise];
    
    // when
    [example methodA];
    
    // then
    [verify(spy) methodA];
}

- (void)testThatVerficationOfStubbedMethodsWorksForDirectCalls
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    [given([spy methodB]) willReturn:@"foo"];
    [spy disguise];
    
    // when
    [example methodB];
    
    // then
    [verify(spy) methodB];
}

- (void)testThatInternalCallsToStubbedMethodsWillUseStubbedImplementaion
{
    // given
    Example *example = [Example new];
    id spy = spy(example);
    [given([spy methodB]) willReturn:@"foo"];
    [spy disguise];
    
    // when
    [spy methodA];
    
    // then
    [verify(spy) methodA];
    [verify(spy) methodB];
    [verify(spy) methodACount];
    [verifyCount(spy, times(0)) methodBCount];
    
    assertThatUnsignedInteger(example.methodACount, is(equalToUnsignedInteger(1)));
    assertThatUnsignedInteger(example.methodBCount, is(equalToUnsignedInteger(0)));
}

@end
