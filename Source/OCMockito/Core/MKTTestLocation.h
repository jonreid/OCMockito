//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef struct
{
    __unsafe_unretained id testCase;
    const char *fileName;
    int lineNumber;
} MKTTestLocation;


static inline MKTTestLocation MKTTestLocationMake(id test, const char *file, int line)
{
    MKTTestLocation location;
    location.testCase = test;
    location.fileName = file;
    location.lineNumber = line;
    return location;
}

void MKTFailTest(id testCase, const char *fileName, int lineNumber, NSString *description);
void MKTFailTestLocation(MKTTestLocation testLocation, NSString *description);

NS_ASSUME_NONNULL_END
