//  OCMockito by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

#import "MKTStructArgumentGetter.h"

typedef struct {} MKTDummyStructure;


@implementation MKTStructArgumentGetter

- (instancetype)initWithSuccessor:(nullable MKTArgumentGetter *)successor
{
    self = [super initWithType:@encode(MKTDummyStructure) successor:successor];
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
