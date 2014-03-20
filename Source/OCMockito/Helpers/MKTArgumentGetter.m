#import "MKTArgumentGetter.h"

@interface MKTArgumentGetter (SubclassResponsibility)
- (id)getArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation;
@end


@implementation MKTArgumentGetter
{
    char const *_handlerType;
}

- (instancetype)initWithType:(char const *)handlerType
{
    self = [super init];
    if (self)
        _handlerType = handlerType;
    return self;
}

- (BOOL)handlesArgumentType:(char const *)argType
{
    return argType[0] == _handlerType[0];
}

- (id)retrieveArgumentAtIndex:(NSInteger)idx ofType:(char const *)type onInvocation:(NSInvocation *)invocation
{
    if ([self handlesArgumentType:type])
        return [self getArgumentAtIndex:idx ofType:type onInvocation:invocation];
    else
        return [self.successor retrieveArgumentAtIndex:idx ofType:type onInvocation:invocation];
}

@end
