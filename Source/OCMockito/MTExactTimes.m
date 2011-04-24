//
//  OCMockito - MTExactTimes.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MTExactTimes.h"

#import "MTInvocationContainer.h"
#import "MTInvocationMatcher.h"
#import "MTTestLocation.h"
#import "MTVerificationData.h"
#import "NSException+OCMockito.h"


// As of 2010-09-09, the iPhone simulator has a bug where you can't catch exceptions when they are
// thrown across NSInvocation boundaries. (See http://openradar.appspot.com/8081169 ) So instead of
// using an NSInvocation to call -failWithException: without linking in SenTestingKit, we simply
// pretend it exists on NSObject.
@interface NSObject (MTExceptionBugHack)
- (void)failWithException:(NSException *)exception;
@end


@interface MTExactTimes ()
@property(nonatomic, assign) NSUInteger wantedCount;
@end


@implementation MTExactTimes

@synthesize wantedCount;

+ (id)timesWithCount:(NSUInteger)wantedNumberOfInvocations
{
    return [[[self alloc] initWithCount:wantedNumberOfInvocations] autorelease];
}


- (id)initWithCount:(NSUInteger)wantedNumberOfInvocations
{
    self = [super init];
    if (self)
        wantedCount = wantedNumberOfInvocations;
    return self;
}


#pragma mark -
#pragma mark MTVerificationMode

- (void)verifyData:(MTVerificationData *)data
{
    NSUInteger matchingCount = 0;
    for (NSInvocation *invocation in [[data invocations] registeredInvocations])
    {
        if ([[data wanted] matches:invocation])
            ++matchingCount;
    }
    
    if (matchingCount != wantedCount)
    {
        MTTestLocation testLocation = [data testLocation];
        NSString *fileName = [NSString stringWithCString:testLocation.fileName
                                                encoding:NSUTF8StringEncoding];
        NSException *failure = [NSException failureInFile:fileName
                                                   atLine:testLocation.lineNumber
                                                   reason:@"need better description here"];
        [testLocation.testCase failWithException:failure];
    }
}

@end
