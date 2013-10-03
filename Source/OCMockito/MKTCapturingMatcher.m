#import "MKTCapturingMatcher.h"


@implementation MKTCapturingMatcher
{
    NSMutableArray *_arguments;
}

- (HCIsAnything *)init
{
    self = [super initWithDescription:@"<Capturing argument>"];
    if (self)
        _arguments = [[NSMutableArray alloc] init];
    return self;
}

- (void)captureArgument:(id)arg
{
    if (!arg)
        arg = [NSNull null];
    [_arguments addObject:arg];
}

- (NSArray *)getAllValues
{
    return _arguments;
}

- (id)getLastValue
{
    if ([self noArgumentWasCaptured])
        return [self throwNoArgumentException];
    return [self convertNilArgument:[_arguments lastObject]];
}

- (BOOL)noArgumentWasCaptured
{
    return [_arguments count] == 0;
}

- (id)throwNoArgumentException
{
    @throw [NSException exceptionWithName:@"NoArgument"
                                       reason:@"No argument captured"
                                     userInfo:nil];
}

- (id)convertNilArgument:(id)arg
{
    if (arg == [NSNull null])
        arg = nil;
    return arg;
}

@end
