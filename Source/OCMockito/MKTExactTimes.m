//
//  OCMockito - MKTExactTimes.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTExactTimes.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTTestLocation.h"
#import "MKVerificationData.h"
#import "NSException+OCMockito.h"


// As of 2010-09-09, the iPhone simulator has a bug where you can't catch exceptions when they are
// thrown across NSInvocation boundaries. (See http://openradar.appspot.com/8081169 ) So instead of
// using an NSInvocation to call -failWithException: without linking in SenTestingKit, we simply
// pretend it exists on NSObject.
@interface NSObject (MTExceptionBugHack)
- (void)failWithException:(NSException *)exception;
@end


@interface MKTExactTimes ()
@property(nonatomic, assign) NSUInteger expectedCount;
@end


@implementation MKTExactTimes

@synthesize expectedCount;

+ (id)timesWithCount:(NSUInteger)expectedNumberOfInvocations
{
    return [[[self alloc] initWithCount:expectedNumberOfInvocations] autorelease];
}

- (id)initWithCount:(NSUInteger)expectedNumberOfInvocations
{
    self = [super init];
    if (self)
        expectedCount = expectedNumberOfInvocations;
    return self;
}


#pragma mark - MTVerificationMode

- (void)verifyData:(MKVerificationData *)data
{
    NSUInteger matchingCount = 0;
    for (NSInvocation *invocation in [[data invocations] registeredInvocations])
    {
        if ([[data wanted] matches:invocation])
            ++matchingCount;
    }
    
    if (matchingCount != expectedCount)
    {
        NSString *plural = (expectedCount == 1) ? @"" : @"s";
        NSString *description = [NSString stringWithFormat:@"Expected %d matching invocation%@, but received %d",
                                 expectedCount, plural, matchingCount];
        
        MKTTestLocation testLocation = [data testLocation];
        NSString *fileName = [NSString stringWithCString:testLocation.fileName
                                                encoding:NSUTF8StringEncoding];
        NSException *failure = [NSException failureInFile:fileName
                                                   atLine:testLocation.lineNumber
                                                   reason:description];
        [testLocation.testCase failWithException:failure];
    }
}

@end
