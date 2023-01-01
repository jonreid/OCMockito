// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2023 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

@import Foundation;


#define stubSingletonWithMockTestCase(mockClass, aSelector, mockTestCase)  \
    MKTStubSingletonWithLocation(mockClass, aSelector, mockTestCase, __FILE__, __LINE__)

#define verifyWithMockTestCase(mock, mockTestCase)  \
    MKTVerifyWithLocation(mock, mockTestCase, __FILE__, __LINE__)

#define verifyCountWithMockTestCase(mock, mode, mockTestCase)  \
    MKTVerifyCountWithLocation(mock, mode, mockTestCase, __FILE__, __LINE__)

#define stopMockingWithMockTestCase(mock, mockTestCase)  \
    MKTStopMockingWithLocation(mock, mockTestCase, __FILE__, __LINE__)


@interface MockTestCase : NSObject

@property (nonatomic, assign) NSUInteger failureCount;
@property (nonatomic, strong) NSException *failureException;
@property (nonatomic, copy) NSString *failureDescription;

- (void)failWithException:(NSException *)exception;
- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected;

@end
