//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTCapturingMatcher.h"


@interface MKTCapturingMatcher ()
@property (nonatomic, strong, readonly) NSMutableArray *arguments;
@end

@implementation MKTCapturingMatcher

- (instancetype)init
{
    self = [super initWithDescription:@"<Capturing argument>"];
    if (self)
        _arguments = [[NSMutableArray alloc] init];
    return self;
}

- (BOOL)matches:(id)item
{
    [self capture:item];
    return [super matches:item];
}

- (void)capture:(id)item
{
    id object = item ?: [NSNull null];
    [self.arguments addObject:object];
}

- (NSArray *)allValues
{
    return self.arguments;
}

- (id)lastValue
{
    if ([self.arguments count] == 0)
        return [self throwNoArgumentException];
    id value = [self.arguments lastObject];
    return value == [NSNull null] ? nil : value;
}

- (id)throwNoArgumentException
{
    @throw [NSException exceptionWithName:@"NoArgument"
                                   reason:@"No argument value was captured!\n"
                                           "You might have forgotten to use [argument capture] in verify()"
                                 userInfo:nil];
}

@end
