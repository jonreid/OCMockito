//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCallStackElement.h"


static NSRange trimTrailingSpacesFromRange(NSString *string, NSRange range)
{
    while ([string characterAtIndex:range.location + range.length - 1] == ' ')
        range.length -= 1;
    return range;
}

static NSString *extractModuleName(NSString *element)
{
    NSRange range = trimTrailingSpacesFromRange(element, NSMakeRange(6, 33));
    return [element substringWithRange:range];
}

static NSString *extractInstruction(NSString *element)
{
    NSRange range = NSMakeRange(61, element.length - 61);
    return [element substringWithRange:range];
}


@implementation MKTCallStackElement

- (instancetype)initWithSymbols:(NSString *)element
{
    self = [super init];
    if (self)
    {
        _moduleName = extractModuleName(element);
        _instruction = extractInstruction(element);
    }
    return self;
}

@end
