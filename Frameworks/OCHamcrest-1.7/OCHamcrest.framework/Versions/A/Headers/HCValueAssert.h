#import <Foundation/Foundation.h>
#import "HCAssertThat.h"

@protocol HCMatcher;

OBJC_EXPORT void HC_assertThatPointWithLocation(id testCase, NSPoint actual,
        id<HCMatcher> matcher, const char* fileName, int lineNumber);

#define HC_assertThatPoint(actual, matcher) \
    HC_assertThatWithLocation(self, [NSValue valueWithPoint:actual], matcher, __FILE__, __LINE__)

#ifdef HC_SHORTHAND
    #define assertThatPoint HC_assertThatPoint
#endif


OBJC_EXPORT void HC_assertThatSizeWithLocation(id testCase, NSSize actual,
        id<HCMatcher> matcher, const char* fileName, int lineNumber);

#define HC_assertThatSize(actualSize, matcher) \
    HC_assertThatWithLocation(self, [NSValue valueWithSize:actualSize], matcher, __FILE__, __LINE__)

#ifdef HC_SHORTHAND
    #define assertThatSize HC_assertThatSize
#endif


OBJC_EXPORT void HC_assertThatRectWithLocation(id testCase, NSRect actual,
        id<HCMatcher> matcher, const char* fileName, int lineNumber);

#define HC_assertThatRect(actualRect, matcher) \
    HC_assertThatWithLocation(self, [NSValue valueWithRect:actualRect], matcher, __FILE__, __LINE__)

#ifdef HC_SHORTHAND
    #define assertThatRect HC_assertThatRect
#endif

OBJC_EXPORT void HC_assertThatRangeWithLocation(id testCase, NSRange actual,
        id<HCMatcher> matcher, const char* fileName, int lineNumber);

#define HC_assertThatRange(actualRange, matcher) \
    HC_assertThatWithLocation(self, [NSValue valueWithRange:actualRange], matcher, __FILE__, __LINE__)

#ifdef HC_SHORTHAND
    #define assertThatRange HC_assertThatRange
#endif
