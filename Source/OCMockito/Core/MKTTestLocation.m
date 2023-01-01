// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTTestLocation.h"

#import <OCHamcrest/HCTestFailure.h>
#import <OCHamcrest/HCTestFailureReporter.h>
#import <OCHamcrest/HCTestFailureReporterChain.h>

void MKTFailTest(id testCase, const char *fileName, int lineNumber, NSString *description)
{
    HCTestFailure *failure = [[HCTestFailure alloc] initWithTestCase:testCase
                                                            fileName:[NSString stringWithUTF8String:fileName]
                                                          lineNumber:(NSUInteger)lineNumber
                                                              reason:description];
    HCTestFailureReporter *failureReporter = [HCTestFailureReporterChain reporterChain];
    [failureReporter handleFailure:failure];
}

void MKTFailTestLocation(MKTTestLocation testLocation, NSString *description)
{
    MKTFailTest(testLocation.testCase, testLocation.fileName, testLocation.lineNumber, description);
}
