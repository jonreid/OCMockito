//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


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
