//
//  NSInvocation+TKAdditions.m
//
//  Created by Taras Kalapun
//

#import "NSInvocation+TKAdditions.h"

#import "MKTReturnTypeSetterChain.h"
#import "MKTReturnTypeSetter.h"

typedef void (^TKBlockType)(void);
typedef struct {} MKTDummyStructure;


@implementation NSInvocation (TKAdditions)

- (NSArray *)tk_arrayArguments
{
    NSMethodSignature *sig = self.methodSignature;

    const char* argType;
    NSUInteger i;
    NSUInteger argc = [sig numberOfArguments];

    NSMutableArray *args = [NSMutableArray arrayWithCapacity:argc-2];

    for (i = 2; i < argc; i++) { // self and _cmd are at index 0 and 1

        argType = [sig getArgumentTypeAtIndex:i];
        NSUInteger ai = i-2;

        if (strcmp(argType, @encode(TKBlockType)) == 0)
        {
            __unsafe_unretained id arg = nil;
            [self getArgument:&arg atIndex:i];
            [args insertObject:(arg ? [arg copy] : [NSNull null]) atIndex:ai];
        }
        else if (argType[0] == @encode(id)[0])
        {
            __unsafe_unretained id arg = nil;
            [self getArgument:&arg atIndex:i];
            [args insertObject:(arg ? arg : [NSNull null]) atIndex:ai];
        }
        else if (strcmp(argType, @encode(SEL)) == 0)
        {
            SEL arg = nil;
            [self getArgument:&arg atIndex:i];
            [args insertObject:(arg ? NSStringFromSelector(arg) : [NSNull null]) atIndex:ai];
        }
        else if (strcmp(argType, @encode(Class)) == 0)
        {
            __unsafe_unretained Class arg = nil;
            [self getArgument:&arg atIndex:i];
            [args insertObject:arg atIndex:ai];
        }
        else if (strcmp(argType, @encode(char)) == 0)
        {
            char arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithChar:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(unsigned char)) == 0)
        {
            unsigned char arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedChar:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(int)) == 0)
        {
            int arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithInt:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(BOOL)) == 0)
        {
            BOOL arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithBool:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(short)) == 0)
        {
            short arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithShort:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(unsigned short)) == 0)
        {
            unsigned short arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedShort:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(float)) == 0)
        {
            float arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithFloat:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(double)) == 0)
        {
            double arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithDouble:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(long)) == 0)
        {
            long arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithLong:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(long long)) == 0)
        {
            long long arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithLongLong:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(unsigned int)) == 0)
        {
            unsigned int arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedInt:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(unsigned long)) == 0)
        {
            unsigned long arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedLong:arg] atIndex:ai];
        }
        else if (strcmp(argType, @encode(unsigned long long)) == 0)
        {
            unsigned long long arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedLongLong:arg] atIndex:ai];
        }
//        else if (strcmp(argType, @encode(const char*)) == 0)
//        {
//            const char *arg;
//            [invocation getArgument:&arg atIndex:i];
//            [args insertObject:[NSString stringWithCString:arg encoding:NSASCIIStringEncoding] atIndex:ai];
//        }
        else if (argType[0] == @encode(void*)[0])
        {
            void *arg;
            [self getArgument:&arg atIndex:i];
            [args insertObject:[NSValue valueWithPointer:arg] atIndex:ai];
        }
        else if(argType[0] == @encode(MKTDummyStructure)[0])
        {
            NSUInteger structSize = 0;
            NSGetSizeAndAlignment(argType, &structSize, NULL);
            void *structMem = calloc(1, structSize);
            [self getArgument:structMem atIndex:i];
            [args insertObject:[NSData dataWithBytes:structMem length:structSize] atIndex:ai];
            free(structMem);
        }
        else
        {
            NSCAssert1(NO, @"-- Unhandled type: %s", argType);
        }
    }

    return args;
}

- (void)mkt_setReturnValue:(id)returnValue
{
    MKTReturnTypeSetter *chain = MKTReturnTypeSetterChain();
    char const *returnType = [[self methodSignature] methodReturnType];
    [chain setReturnValue:returnValue ofType:returnType onInvocation:self];
}

@end
