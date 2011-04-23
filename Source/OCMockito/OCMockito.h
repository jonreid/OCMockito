//
//  OCMockito - OCMockito.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

#import <Foundation/Foundation.h>

#import "MTClassMock.h"
#import "MTOngoingStubbing.h"
#import <objc/objc-api.h>


#define MTMock(aClass) [MTClassMock mockForClass:aClass]

#ifdef MOCKITO_SHORTHAND
    #define mock(aClass) MTMock(aClass)
#endif


OBJC_EXPORT MTOngoingStubbing *MTGivenWithLocation(id methodCall,
                                                   id testCase, const char *fileName, int lineNumber);

#define MTGiven(methodCall) MTGivenWithLocation((id)methodCall, self, __FILE__, __LINE__)

#ifdef MOCKITO_SHORTHAND
    #define given(methodCall) MTGiven(methodCall)
#endif


OBJC_EXPORT id MTVerifyWithLocation(id mock, id testCase, const char *fileName, int lineNumber);

#define MTVerify(mock) MTVerifyWithLocation(mock, self, __FILE__, __LINE__)

#ifdef MOCKITO_SHORTHAND
    #define verify(mock) MTVerify(mock)
#endif
