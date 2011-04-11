//
//  OCMockito - MTLineLocation.h
//  Copyright 2011 Jonathan M. Reid. See LICENSE.txt
//

struct MTLineLocation
{
    const char *fileName;
    int lineNumber;
};
typedef struct MTLineLocation MTLineLocation;


static inline MTLineLocation MTLineLocationMake(const char *file, int line)
{
    MTLineLocation location;
    location.fileName = file;
    location.lineNumber = line;
    return location;
}
