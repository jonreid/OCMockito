//
//  OCMockito - MTTestLocation.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

struct MTTestLocation
{
    id testCase;
    const char *fileName;
    int lineNumber;
};
typedef struct MTTestLocation MTTestLocation;


static inline MTTestLocation MTTestLocationMake(id test, const char *file, int line)
{
    MTTestLocation location;
    location.testCase = test;
    location.fileName = file;
    location.lineNumber = line;
    return location;
}
