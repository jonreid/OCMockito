//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCallStackParser.h"

#import "MKTCallStackElement.h"


@implementation MKTCallStackParser

- (NSArray *)parse:(NSArray *)callStackSymbols
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSString *rawElement in callStackSymbols)
    {
        MKTCallStackElement *element = [[MKTCallStackElement alloc] initWithSymbols:rawElement];
        [result addObject:element];
    }
    return result;
}

@end
