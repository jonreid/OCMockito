//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

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
