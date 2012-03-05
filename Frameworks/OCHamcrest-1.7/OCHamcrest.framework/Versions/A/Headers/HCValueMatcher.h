#import <OCHamcrest/HCBaseMatcher.h>
#import <objc/objc-api.h>

typedef enum {
    SMALLER = -1,
    SAME,
    BIGGER
} SizeMatchMode;

@interface HCValueMatcher : HCBaseMatcher {
    NSValue *_value;
    
    SizeMatchMode _mode;
}

+ (id)isEqualToPoint:(NSPoint)targetPoint;
- (id)initWithPoint:(NSPoint)targetPoint;

+ (id)isEqualToSize:(NSSize)targetSize mode:(SizeMatchMode)mode;
- (id)initWithSize:(NSSize)targetSize mode:(SizeMatchMode)aMode;

+ (id)isEqualToRect:(NSRect)targetRect;
- (id)initWithRect:(NSRect)aRect;

+ (id)isEqualToRange:(NSRange)targetRange;
- (id)initWithRange:(NSRange)targetRange;

@end

OBJC_EXPORT id<HCMatcher> equalToPoint(NSPoint targetPoint);

OBJC_EXPORT id<HCMatcher> smallerThanSize(NSSize targetSize);
OBJC_EXPORT id<HCMatcher> equalToSize(NSSize targetSize);
OBJC_EXPORT id<HCMatcher> biggerThanSize(NSSize targetSize);

OBJC_EXPORT id<HCMatcher> equalToRect(NSRect targetRect);

OBJC_EXPORT id<HCMatcher> equalToRange(NSRange targetRange);
