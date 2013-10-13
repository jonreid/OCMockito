#if TARGET_OS_MAC
    #import <OCHamcrest/HCIsAnything.h>
#else
    #import <OCHamcrestIOS/HCIsAnything.h>
#endif


@interface MKTCapturingMatcher : HCIsAnything

- (void)captureArgument:(id)arg;
- (NSArray *)allValues;
- (id)lastValue;

@end
