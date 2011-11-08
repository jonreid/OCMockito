//
//  OCMockito - OCMockito.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTClassMock.h"
#import "MTOngoingStubbing.h"
#import <objc/objc-api.h>


#define MTMock(aClass) [MTClassMock mockForClass:aClass]

/**
    Creates mock object of given class.

    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTMock instead.
*/
#ifdef MOCKITO_SHORTHAND
    #define mock(aClass) MTMock(aClass)
#endif


OBJC_EXPORT MTOngoingStubbing *MTGivenWithLocation(id methodCall,
                                                   id testCase, const char *fileName, int lineNumber);

#define MTGiven(methodCall) MTGivenWithLocation((id)methodCall, self, __FILE__, __LINE__)

/**
    Enables method stubbing.
 
    Use @c given when you want the mock to return particular value when particular method is called.
 
    Example:
    @li @ref [given([mockObject methodReturningString]) willReturn:@"foo"];
 
    See @ref MTOngoingStubbing for other methods to stub different types of return values.
 
    @c given doesn't work for methods returning @c float or @double values. For such methods,
    invoke the method on the mock object, then use @ref givenPreviousCall.

    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTGiven instead.
*/
#ifdef MOCKITO_SHORTHAND
#define given(methodCall) MTGiven(methodCall)
#endif


OBJC_EXPORT MTOngoingStubbing *MTGivenPreviousCallWithLocation(id testCase, const char *fileName, int lineNumber);

#define MTGivenPreviousCall MTGivenPreviousCallWithLocation(self, __FILE__, __LINE__)


/**
    Enables stubbing of previous method invocation.
 
    Methods that return @c float or @c double values can't be passed to @ref given. For these methods,
    first invoke the method on the mock object. Then use @c givenPreviousCall to stub the return
    value.
 
    Example:
@code
[mockObject methodReturningDouble];
[givenPreviousCall willReturnDouble:42];
@endcode

    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTGivenPreviousCall instead.
 */
#ifdef MOCKITO_SHORTHAND
    #define givenPreviousCall MTGivenPreviousCall
#endif


OBJC_EXPORT id MTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber);

#define MTVerify(mock) MTVerifyWithLocation(mock, self, __FILE__, __LINE__)

/**
    Verifies certain behavior happened once.
 
    @c verify checks that a method was invoked once, with arguments that match given OCHamcrest
    matchers. If an argument is not a matcher, it is implicitly wrapped in an @c equalTo matcher to
    check for equality.
 
    Examples:
@code
[verify(mockObject) someMethod:startsWith(@"foo")];
[verify(mockObject) someMethod:@"bar"];
@endcode
 
    @c verify(mockObject) is equivalent to
@code
verifyCount(mockObject, times(1))
@endcode

    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTVerify instead.
 */
#ifdef MOCKITO_SHORTHAND
    #define verify(mock) MTVerify(mock)
#endif


OBJC_EXPORT id MTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber);

/**
    Verifies certain behavior happened a given number of times.

    Examples:
@code
[verifyCount(mockObject, times(5)) someMethod:@"was called five times"];
[verifyCount(mockObject, never()) someMethod:@"was never called"];
@endcode
 
    @c verify checks that a method was invoked a given number of times, with arguments that match
    given OCHamcrest matchers. If an argument is not a matcher, it is implicitly wrapped in an
    @c equalTo matcher to check for equality.

    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTVerifyCount instead.
 */
#define MTVerifyCount(mock, mode) MTVerifyCountWithLocation(mock, mode, self, __FILE__, __LINE__)

#ifdef MOCKITO_SHORTHAND
    #define verifyCount(mock, mode) MTVerifyCount(mock, mode)
#endif


OBJC_EXPORT id MTTimes(NSUInteger wantedNumberOfInvocations);

/**
    Allows verifying exact number of invocations.
 
    Example:
@code
[verifyCount(mockObject, times(2)) someMethod:@"some arg"];
@endcode
 
    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTTimes instead.
 */
#ifdef MOCKITO_SHORTHAND
    #define times(wantedNumberOfInvocations) MTTimes(wantedNumberOfInvocations)
#endif


OBJC_EXPORT id MTNever(void);

/**
    Verifies that interaction did not happen.

    Example:
@code
[verifyCount(mockObject, never()) someMethod:@"some arg"];
@endcode
 
    In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MTNever instead.
 */
#ifdef MOCKITO_SHORTHAND
    #define never() MTNever()
#endif
