//
//  OCMockito - MKTestLocation.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

typedef struct
{
    id testCase;
    const char *fileName;
    int lineNumber;
} MKTestLocation;


static inline MKTestLocation MKTestLocationMake(id test, const char *file, int line)
{
    MKTestLocation location;
    location.testCase = test;
    location.fileName = file;
    location.lineNumber = line;
    return location;
}
