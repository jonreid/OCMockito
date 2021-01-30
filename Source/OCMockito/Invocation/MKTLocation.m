//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "MKTLocation.h"

#import "MKTFilterCallStack.h"
#import "MKTParseCallStack.h"


@interface MKTLocation ()
@property (nonatomic, strong, readonly) NSArray<NSString *> *callStack; // strong not copy, for speed
@end

@implementation MKTLocation

- (instancetype)init
{
    self = [self initWithCallStack:[NSThread callStackSymbols]];
    return self;
}

- (instancetype)initWithCallStack:(NSArray<NSString *> *)callStack
{
    self = [super init];
    if (self)
        _callStack = callStack;
    return self;
}

- (NSString *)description
{
    NSArray<MKTCallStackElement *> *stack = MKTFilterCallStack(MKTParseCallStack(self.callStack));
    return [stack componentsJoinedByString:@"\n"];
}

@end
