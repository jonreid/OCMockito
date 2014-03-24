//
//  OCMockito - MKTStructArgumentGetter.m
//  Copyright 2014 Jonathan M. Reid. See LICENSE.txt
//
//  Created by: Jon Reid, http://qualitycoding.org/
//  Source: https://github.com/jonreid/OCMockito
//

#import "MKTStructArgumentGetter.h"

typedef struct {} MKTDummyStructure;


@implementation MKTStructArgumentGetter

- (id)init
{
    self = [super initWithType:@encode(MKTDummyStructure)];
    return self;
}

- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    NSUInteger structSize = 0;
    NSGetSizeAndAlignment(type, &structSize, NULL);
    void *structMem = calloc(1, structSize);
    [invocation getArgument:structMem atIndex:idx];
    id arg = [NSData dataWithBytes:structMem length:structSize];
    free(structMem);
    return arg;
}

@end
