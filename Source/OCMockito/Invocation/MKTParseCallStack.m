// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2022 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

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
