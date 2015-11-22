//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCallStackElement.h"


@implementation MKTCallStackElement

- (id)initWithSymbols:(NSString *)rawElement
{
    self = [super init];
    if (self)
    {
        NSRange range = NSMakeRange(6, 33);
        while ([rawElement characterAtIndex:range.location + range.length - 1] == ' ')
            range.length -= 1;
        _moduleName = [rawElement substringWithRange:range];
    }
    return self;
}

@end
