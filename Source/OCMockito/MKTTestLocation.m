//
//  OCMockito - MKTTestLocation.m
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import "MKTTestLocation.h"

#import "NSException+OCMockito.h"


// As of 2010-09-09, the iPhone simulator has a bug where you can't catch exceptions when they are
// thrown across NSInvocation boundaries. (See http://openradar.appspot.com/8081169 ) So instead of
// using an NSInvocation to call -failWithException: without linking in SenTestingKit, we simply
// pretend it exists on NSObject.
@interface NSObject (MTExceptionBugHack)
- (void)failWithException:(NSException *)exception;
@end


void MKTFailTestLocation(MKTTestLocation testLocation, NSString *description)
{
    NSString *fileName = [NSString stringWithCString:testLocation.fileName
                                            encoding:NSUTF8StringEncoding];
    NSException *failure = [NSException mkt_failureInFile:fileName
                                                   atLine:testLocation.lineNumber
                                                   reason:description];
    [testLocation.testCase failWithException:failure];
}
