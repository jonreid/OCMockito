//
//  OCMockito - OCMockito.h
//  Copyright 2013 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import <Foundation/Foundation.h>

#import "MKTClassObjectMock.h"
#import "MKTObjectMock.h"
#import "MKTObjectAndProtocolMock.h"
#import "MKTOngoingStubbing.h"
#import "MKTProtocolMock.h"
#import <objc/objc-api.h>


#define MKTMock(aClass) [MKTObjectMock mockForClass:aClass]

/**
    Returns a mock object of a given class.
 
    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTMock instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define mock(aClass) MKTMock(aClass)
#endif


#define MKTMockClass(aClass) [MKTClassObjectMock mockForClass:aClass]

/**
    Returns a mock class object of a given class.

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTMockClass instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define mockClass(aClass) MKTMockClass(aClass)
#endif


#define MKTMockProtocol(aProtocol) [MKTProtocolMock mockForProtocol:aProtocol]

/**
    Returns a mock object implementing a given protocol.

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTMockProtocol instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define mockProtocol(aProtocol) MKTMockProtocol(aProtocol)
#endif


#define MKTMockObjectAndProtocol(aClass, aProtocol) [MKTObjectAndProtocolMock mockForClass:aClass protocol:aProtocol]

/**
    Returns a mock object of a given class that also implements a given protocol.

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTMockObjectAndProtocol instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define mockObjectAndProtocol(aClass, aProtocol) MKTMockObjectAndProtocol(aClass, aProtocol)
#endif


OBJC_EXPORT MKTOngoingStubbing *MKTGivenWithLocation(id testCase, const char *fileName, int lineNumber, ...);
#define MKTGiven(methodCall) MKTGivenWithLocation(self, __FILE__, __LINE__, methodCall)

/**
    Enables method stubbing.

    Use @c given when you want the mock to return particular value when particular method is called.

    Example:
    @li @ref [given([mockObject methodReturningString]) willReturn:@"foo"];

    See @ref MKTOngoingStubbing for other methods to stub different types of return values.

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTGiven instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define given(methodCall) MKTGiven(methodCall)
#endif


OBJC_EXPORT id MKTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber);
#define MKTVerify(mock) MKTVerifyWithLocation(mock, self, __FILE__, __LINE__)

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

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTVerify instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #undef verify
    #define verify(mock) MKTVerify(mock)
#endif


OBJC_EXPORT id MKTVerifyCountWithLocation(id mock, id mode, id testCase, const char *fileName, int lineNumber);
#define MKTVerifyCount(mock, mode) MKTVerifyCountWithLocation(mock, mode, self, __FILE__, __LINE__)

/**
    Verifies certain behavior happened a given number of times.

    Examples:
@code
[verifyCount(mockObject, times(5)) someMethod:@"was called five times"];
[verifyCount(mockObject, never()) someMethod:@"was never called"];
@endcode

    @c verifyCount checks that a method was invoked a given number of times, with arguments that
    match given OCHamcrest matchers. If an argument is not a matcher, it is implicitly wrapped in an
    @c equalTo matcher to check for equality.

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTVerifyCount instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define verifyCount(mock, mode) MKTVerifyCount(mock, mode)
#endif


OBJC_EXPORT id MKTTimes(NSUInteger wantedNumberOfInvocations);
OBJC_EXPORT id MKTEventuallyTimes(NSUInteger wantedNumberOfInvocations);

/**
    Verifies exact number of invocations.

    Example:
@code
[verifyCount(mockObject, times(2)) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTTimes instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define times(wantedNumberOfInvocations) MKTTimes(wantedNumberOfInvocations)
#endif

/**
    Verifies exact number of invocations now, or at some time in the near future.

    Example:
@code
[verifyCount(mockObject, eventuallyTimes(2)) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTEventuallyTimes instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define eventuallyTimes(wantedNumberOfInvocations) MKTEventuallyTimes(wantedNumberOfInvocations)
#endif


OBJC_EXPORT id MKTNever(void);
OBJC_EXPORT id MKTEventuallyNever(void);

/**
    Verifies that interaction did not happen.

    Example:
    @code
    [verifyCount(mockObject, never()) someMethod:@"some arg"];
    @endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTNever instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define never() MKTNever()
#endif

/**
    Verifies that interaction did not happen now, or at some time in the near future.

    Example:
    @code
    [verifyCount(mockObject, eventuallyNever()) someMethod:@"some arg"];
    @endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTEventuallyNever instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define eventuallyNever() MKTEventuallyNever()
#endif


OBJC_EXPORT id MKTAtLeast(NSUInteger minimumWantedNumberOfInvocations);
OBJC_EXPORT id MKTEventuallyAtLeast(NSUInteger minimumWantedNumberOfInvocations);

/**
    Verifies minimum number of invocations.

    The verification will succeed if the specified invocation happened the number of times
    specified or more.

    Example:
@code
[verifyCount(mockObject, atLeast(2)) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTAtLeast instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define atLeast(minimumWantedNumberOfInvocations) MKTAtLeast(minimumWantedNumberOfInvocations)
#endif

/**
    Verifies minimum number of invocations now, or at some time in the near future.

    The verification will succeed if the specified invocation happened the number of times
    specified or more.

    Example:
@code
[verifyCount(mockObject, eventuallyAtLeast(2)) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTEventuallyAtLeast instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define eventuallyAtLeast(minimumWantedNumberOfInvocations) MKTEventuallyAtLeast(minimumWantedNumberOfInvocations)
#endif


OBJC_EXPORT id MKTAtLeastOnce(void);
OBJC_EXPORT id MKTEventuallyAtLeastOnce(void);

/**
    Verifies that interaction happened once or more.

    Example:
@code
[verifyCount(mockObject, atLeastOnce()) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTAtLeastOnce instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define atLeastOnce() MKTAtLeastOnce()
#endif

/**
    Verifies that interaction happened once or more now, or at some time in the near future.

    Example:
@code
[verifyCount(mockObject, atLeastOnce()) someMethod:@"some arg"];
@endcode

    (In the event of a name clash, don't \#define @c MOCKITO_SHORTHAND and use the synonym
    @c MKTEventuallyAtLeastOnce instead.)
 */
#ifdef MOCKITO_SHORTHAND
    #define eventuallyAtLeastOnce() MKTEventuallyAtLeastOnce()
#endif


/**
 Retrieves the default timeout used by @c eventuallyTimes, @c eventuallyNever,
 @c eventuallyAtLeast and @c eventuallyAtLeastOnce.

 The default value is 1 second.
 */
OBJC_EXPORT NSTimeInterval MKT_eventuallyDefaultTimeout(void);

/**
 Sets the default timeout used by @c eventuallyTimes, @c eventuallyNever,
 @c eventuallyAtLeast and @c eventuallyAtLeastOnce.
 */
OBJC_EXPORT void MKT_setEventuallyDefaultTimeout(NSTimeInterval defaultTimeout);
