//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 Jonathan M. Reid. See LICENSE.txt

#import <OCMockito/OCMockito.h>
#import "MKTPrinter.h"


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
        [result appendFormat:@" %@:@%@", selectorParts[index], arguments[index]];
    return [result substringFromIndex:1]; // Remove first space
}

@end
