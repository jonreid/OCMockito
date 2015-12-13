//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTPrinter.h"

#import "NSInvocation+OCMockito.h"


@implementation MKTPrinter

- (NSString *)printInvocation:(NSInvocation *)invocation
{
    NSString *selector = NSStringFromSelector(invocation.selector);
    if (invocation.methodSignature.numberOfArguments == 2) // Indices 0 and 1 are self and _cmd
        return selector;
    
    NSArray *arguments = [invocation mkt_arguments];
    NSArray *selectorParts = [selector componentsSeparatedByString:@":"];
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSUInteger index = 0; index < arguments.count; ++index)
        [result appendFormat:@" %@:%@", selectorParts[index], [self printArgument:arguments[index]]];
    return [result substringFromIndex:1]; // Remove first space
}

- (NSString *)printArgument:(id)arg
{
    if (arg == [NSNull null])
        return [self printNil];
    if ([arg isKindOfClass:[NSString class]])
        return [self printNSString:arg];
    if ([arg isKindOfClass:[NSNumber class]])
        return [self printNSNumber:arg];
    return [arg description];
}

- (NSString *)printNil
{
    return @"nil";
}

- (NSString *)printNSString:(id)arg
{
    return [NSString stringWithFormat:@"@\"%@\"", arg];
}

- (NSString *)printNSNumber:(id)arg
{
    return [NSString stringWithFormat:@"@%@", arg];
}

@end
