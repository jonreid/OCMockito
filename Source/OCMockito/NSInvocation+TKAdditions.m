//
//  NSInvocation+TKAdditions.m
//
//  Created by Taras Kalapun
//

#import "NSInvocation+TKAdditions.h"


NSArray *TKArrayArgumentsForInvocation(NSInvocation *invocation)
{
    NSMethodSignature *sig = invocation.methodSignature;

    const char* argType;
    NSUInteger i;
    NSUInteger argc = [sig numberOfArguments];
    
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:argc-2];
    
    for (i = 2; i < argc; i++) { // self and _cmd are at index 0 and 1
        
        argType = [sig getArgumentTypeAtIndex:i];
        NSUInteger ai = i-2;

        if (argType[0] == @encode(id)[0]) {
            __unsafe_unretained id arg = nil;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:arg?arg:[NSNull null] atIndex:ai];
        } else if(!strcmp(argType, @encode(SEL))) {
            SEL arg = nil;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:NSStringFromSelector(arg) atIndex:ai];
        } else if(!strcmp(argType, @encode(Class))) {
            __unsafe_unretained Class arg = nil;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:arg atIndex:ai];
        } else if(!strcmp(argType, @encode(char))) {
            char arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithChar:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(unsigned char))) {
            unsigned char arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedChar:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(int))) {
            int arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithInt:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(bool))) {
            bool arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithBool:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(BOOL))) {
            BOOL arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithBool:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(short))) {
            short arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithShort:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(unichar))) {
            unichar arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedShort:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(float))) {
            float arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithFloat:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(double))) {
            double arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithDouble:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(long))) {
            long arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithLong:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(long long))) {
            long long arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithLongLong:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(unsigned int))) {
            unsigned int arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedInt:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(unsigned long))) {
            unsigned long arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedLong:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(unsigned long long))) {
            unsigned long long arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSNumber numberWithUnsignedLongLong:arg] atIndex:ai];
        } else if(!strcmp(argType, @encode(char*))) {
            char* arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:[NSString stringWithCString:arg encoding:NSASCIIStringEncoding] atIndex:ai];
        } else if(!strcmp(argType, @encode(void*))) {
            void* arg;
            [invocation getArgument:&arg atIndex:i];
            [args insertObject:(__bridge id)(arg) atIndex:ai];
        } else {
            NSCAssert1(NO, @"-- Unhandled type: %s", argType);
        }
    }
    
    return args;
}

void MKTSetReturnValueForInvocation(NSInvocation *invocation, id returnValue)
{
    NSMethodSignature *methodSignature = [invocation methodSignature];
    const char*returnType = [methodSignature methodReturnType];
    if (returnType[0] == @encode(id)[0])
    {
        __unsafe_unretained id value = returnValue;
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(Class)) == 0)
    {
        __unsafe_unretained Class value = returnValue;
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(char)) == 0)
    {
        char value = [returnValue charValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(int)) == 0)
    {
        int value = [returnValue intValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(short)) == 0)
    {
        int value = [returnValue shortValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(long)) == 0)
    {
        long value = [returnValue longValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(long long)) == 0)
    {
        long long value = [returnValue longLongValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(unsigned char)) == 0)
    {
        unsigned char value = [returnValue unsignedCharValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(unsigned int)) == 0)
    {
        unsigned int value = [returnValue unsignedIntValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(unsigned short)) == 0)
    {
        unsigned short value = [returnValue unsignedShortValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(unsigned long)) == 0)
    {
        unsigned long value = [returnValue unsignedLongValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(unsigned long long)) == 0)
    {
        unsigned long long value = [returnValue unsignedLongLongValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(float)) == 0)
    {
        float value = [returnValue floatValue];
        [invocation setReturnValue:&value];
    }
    else if(strcmp(returnType, @encode(double)) == 0)
    {
        double value = [returnValue doubleValue];
        [invocation setReturnValue:&value];
    }
}
