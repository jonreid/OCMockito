//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import "MKTPrinter.h"

#import "NSInvocation+OCMockito.h"


@implementation MKTPrinter

- (NSString *)printInvocation:(NSInvocation *)invocation
{
    if ([self invocationHasNoArguments:invocation])
        return [self printInvocationWithNoArguments:invocation];
    return [self printInvocationWithArguments:invocation];
}

- (BOOL)invocationHasNoArguments:(NSInvocation *)invocation
{
    return invocation.methodSignature.numberOfArguments == 2; // Indices 0 and 1 are self and _cmd
}

- (NSString *)printInvocationWithNoArguments:(NSInvocation *)invocation
{
    return NSStringFromSelector(invocation.selector);
}

- (NSString *)printInvocationWithArguments:(NSInvocation *)invocation
{
    NSArray *arguments = [invocation mkt_arguments];
    NSArray *selectorParts = [NSStringFromSelector(invocation.selector) componentsSeparatedByString:@":"];
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSUInteger index = 0; index < arguments.count; ++index)
    {
        const char *argType = [invocation.methodSignature getArgumentTypeAtIndex:index + 2];
        [result appendFormat:@" %@:%@", selectorParts[index], [self printArgument:arguments[index] type:argType]];
    }
    return [result substringFromIndex:1]; // Remove first space
}

- (NSString *)printArgument:(id)arg type:(const char *)type
{
    if (arg == [NSNull null])
        return [self printNil];
    if (type[0] == @encode(Class)[0])
        return [self printClass:arg];
    if (type[0] == @encode(SEL)[0])
        return [self printSelector:arg];
    if ([arg isKindOfClass:[NSString class]])
        return [self printString:arg];
    if ([arg isKindOfClass:[NSNumber class]])
        return [self printNumber:arg type:type];
    if ([arg isKindOfClass:[NSArray class]])
        return [self printArray:arg];
    return [arg description];
}

- (NSString *)printNil
{
    return @"nil";
}

- (NSString *)printClass:(id)className
{
    return [NSString stringWithFormat:@"[%@ class]", className];
}

- (NSString *)printSelector:(id)arg
{
    return [NSString stringWithFormat:@"@selector(%@)", arg];
}

- (NSString *)printString:(id)arg
{
    return [NSString stringWithFormat:@"@\"%@\"", arg];
}

- (NSString *)printNumber:(id)arg type:(const char *)type
{
    if (type[0] == @encode(id)[0])
        return [NSString stringWithFormat:@"@%@", arg];
    if (type[0] == @encode(BOOL)[0])
        return [arg boolValue] ? @"YES" : @"NO";
    return [arg description];
}

- (NSString *)printArray:(id)arg
{
    NSMutableArray *printedArgs = [[NSMutableArray alloc] init];
    for (id item in arg)
        [printedArgs addObject:[self printArgument:item type:@encode(id)]];
    NSString *joinedArgs = [printedArgs componentsJoinedByString:@", "];
    return [NSString stringWithFormat:@"@[%@]", joinedArgs];
}

@end
