//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTParseCallStack.h"

#import "MKTCallStackElement.h"


NSArray<MKTCallStackElement *> *MKTParseCallStack(NSArray<NSString *> *callStackSymbols)
{
    NSMutableArray<MKTCallStackElement *> *result = [[NSMutableArray alloc] init];
    for (NSString *rawElement in callStackSymbols)
    {
        MKTCallStackElement *element = [[MKTCallStackElement alloc] initWithSymbols:rawElement];
        [result addObject:element];
    }
    return result;
}
