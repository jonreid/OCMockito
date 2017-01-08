//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

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
