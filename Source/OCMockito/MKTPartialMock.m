//
//  MKTPartialMock.m
//  OCMockito
//
//  Created by Erik Blomqvist on 2013-10-20.
//  Copyright (c) 2013 Erik Blomqvist. All rights reserved.
//

#import "MKTPartialMock.h"

#import <objc/runtime.h>

static NSString * const OCMRealMethodAliasPrefix = @"ocmockito_replaced_";

static const NSString * const mockObject = @"mockObject";

@interface NSMethodSignature(OCMAdditions)

- (const char *)methodReturnTypeWithoutQualifiers;
- (BOOL)usesSpecialStructureReturn;

@end

@implementation NSMethodSignature(OCMAdditions)

- (const char *)methodReturnTypeWithoutQualifiers
{
	const char *returnType = [self methodReturnType];
	while(strchr("rnNoORV", returnType[0]) != NULL)
		returnType += 1;
	return returnType;
}

- (BOOL)usesSpecialStructureReturn
{
    const char *types = [self methodReturnTypeWithoutQualifiers];
    
    if((types == NULL) || (types[0] != '{'))
        return NO;
    
    /* In some cases structures are returned by ref. The rules are complex and depend on the
     architecture, see:
     
     http://sealiesoftware.com/blog/archive/2008/10/30/objc_explain_objc_msgSend_stret.html
     http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/LowLevelABI/000-Introduction/introduction.html
     https://github.com/atgreen/libffi/blob/master/src/x86/ffi64.c
     http://www.uclibc.org/docs/psABI-x86_64.pdf
     
     NSMethodSignature knows the details but has no API to return it, though it is in
     the debugDescription. Horribly kludgy.
     */
    NSRange range = [[self debugDescription] rangeOfString:@"is special struct return? YES"];
    return range.length > 0;
}

@end

@interface MKTPartialMock ()

@property (nonatomic, readonly) Class spiedClass;

@end

@implementation MKTPartialMock
{
    id _spiedObject;
    Class _spiedClass;
    BOOL _disguised;
}

+ (id)mockForObject:(id)spiedObject {
    return [[MKTPartialMock alloc] initWithObject:spiedObject];
}

- (id)initWithObject:(id)spiedObject
{
    self = [super init];
    if (self) {
        _spiedObject = spiedObject;
        _spiedClass = [spiedObject class];
        
        [self setupSubclassForObject:_spiedObject];
        // The spied object needs to be able to easily access the mock object.
        objc_setAssociatedObject(_spiedObject, (__bridge const void *)(mockObject), self, OBJC_ASSOCIATION_ASSIGN);
        
        // Put all methods in quaranteen.
        [self forwardAllMethods];
    }
    return self;
}

- (void)forwardAllMethods {
    Class cls = _spiedClass;
    do {
        unsigned int count;
        Method *methods = class_copyMethodList(cls, &count);
        for (unsigned int i = 0; i < count; i++) {
            SEL selector = method_getName(methods[i]);
            [self setupForwarderForSelector:selector];
        }
    } while ((cls = class_getSuperclass(cls)) != [NSObject class]);
}

- (void)disguise {
    _disguised = YES;
}

- (void)answerInvocation:(NSInvocation *)invocation
{
    if (_disguised) {
        // It doesn't matter whether the method is stubbed or not, since the _spiedObject knows what to do.
        [invocation invokeWithTarget:_spiedObject];
    }
}

- (void)prepareInvocationForStubbing:(NSInvocation *)invocation
{
    if (!_disguised) {
        [super prepareInvocationForStubbing:invocation];
        // Instead of just forwarding stubbed methods, we should forward all methods.
//        [self setupForwarderForSelector:invocation.selector];
    }
}

- (void)registerInvocation:(NSInvocation *)invocation {
    [super prepareInvocationForStubbing:invocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [[_spiedObject class] instanceMethodSignatureForSelector:aSelector];
}

#pragma mark NSObject protocol

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_spiedClass isSubclassOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_spiedClass instancesRespondToSelector:aSelector];
}

#pragma mark  Subclass management

- (void)setupSubclassForObject:(id)anObject
{
	Class realClass = [anObject class];
	double timestamp = [NSDate timeIntervalSinceReferenceDate];
	const char *className = [[NSString stringWithFormat:@"%@-%p-%f", NSStringFromClass(realClass), anObject, timestamp] UTF8String];
	Class subclass = objc_allocateClassPair(realClass, className, 0);
	objc_registerClassPair(subclass);
	object_setClass(anObject, subclass);
    
	Method myForwardInvocationMethod = class_getInstanceMethod([self class], @selector(forwardInvocationForRealObject:));
	IMP myForwardInvocationImp = method_getImplementation(myForwardInvocationMethod);
	const char *forwardInvocationTypes = method_getTypeEncoding(myForwardInvocationMethod);
	class_addMethod(subclass, @selector(forwardInvocation:), myForwardInvocationImp, forwardInvocationTypes);
    
    
    Method myForwardingTargetForSelectorMethod = class_getInstanceMethod([self class], @selector(forwardingTargetForSelectorForRealObject:));
    IMP myForwardingTargetForSelectorImp = method_getImplementation(myForwardingTargetForSelectorMethod);
    const char *forwardingTargetForSelectorTypes = method_getTypeEncoding(myForwardingTargetForSelectorMethod);
    
    IMP originalForwardingTargetForSelectorImp = [realClass instanceMethodForSelector:@selector(forwardingTargetForSelector:)];
    
    class_addMethod(subclass, @selector(forwardingTargetForSelector:), myForwardingTargetForSelectorImp, forwardingTargetForSelectorTypes);
    class_addMethod(subclass, @selector(forwardingTargetForSelector_Original:), originalForwardingTargetForSelectorImp, forwardingTargetForSelectorTypes);
    
    /* We also override the -class method to return the original class */
    Method myObjectClassMethod = class_getInstanceMethod([self class], @selector(classForRealObject));
    const char *objectClassTypes = method_getTypeEncoding(myObjectClassMethod);
    IMP myObjectClassImp = method_getImplementation(myObjectClassMethod);
    IMP originalClassImp = [realClass instanceMethodForSelector:@selector(class)];
    
    class_addMethod(subclass, @selector(class), myObjectClassImp, objectClassTypes);
    class_addMethod(subclass, @selector(class_Original), originalClassImp, objectClassTypes);
}

- (void)setupForwarderForSelector:(SEL)selector
{
	Class subclass = object_getClass(_spiedObject);
	Method originalMethod = class_getInstanceMethod(_spiedClass, selector);
	IMP originalImp = method_getImplementation(originalMethod);
    
    NSMethodSignature *signature = [_spiedClass instanceMethodSignatureForSelector:selector];
    // TODO: below we shouldn't really use getTypeEncoding because that doesn't work for methods implemented with -forwardingTargetForSelector:
	IMP forwarderImp;
	if([signature usesSpecialStructureReturn])
		forwarderImp = class_getMethodImplementation_stret(subclass, NSSelectorFromString(@"aMethodThatMustNotExist"));
	else
		forwarderImp = class_getMethodImplementation(subclass, NSSelectorFromString(@"aMethodThatMustNotExist"));
	class_addMethod(subclass, method_getName(originalMethod), forwarderImp, method_getTypeEncoding(originalMethod));
    
	SEL aliasSelector = NSSelectorFromString([OCMRealMethodAliasPrefix stringByAppendingString:NSStringFromSelector(selector)]);
	class_addMethod(subclass, aliasSelector, originalImp, method_getTypeEncoding(originalMethod));
}

- (void)removeForwarderForSelector:(SEL)selector
{
    Class subclass = object_getClass(_spiedObject);
    SEL aliasSelector = NSSelectorFromString([OCMRealMethodAliasPrefix stringByAppendingString:NSStringFromSelector(selector)]);
    Method originalMethod = class_getInstanceMethod(_spiedClass, aliasSelector);
  	IMP originalImp = method_getImplementation(originalMethod);
    class_replaceMethod(subclass, selector, originalImp, method_getTypeEncoding(originalMethod));
}

//  Make the compiler happy in -forwardingTargetForSelectorForRealObject: because it can't find the message…
- (id)forwardingTargetForSelector_Original:(SEL)sel
{
    return nil;
}

// I personally have no clue why this is needed, but I figure it's in OCMock for a reason.
- (id)forwardingTargetForSelectorForRealObject:(SEL)sel
{
	// in here "self" is a reference to the real object, not the mock
    MKTPartialMock *mock = objc_getAssociatedObject(self, (__bridge const void *)(mockObject));
    if ([mock hasAnswerForSelector:sel])
        return self;
    
    return [self forwardingTargetForSelector_Original:sel];
}

- (void)forwardInvocationForRealObject:(NSInvocation *)anInvocation
{
	// in here "self" is a reference to the real object, not the mock
	MKTPartialMock *mock = objc_getAssociatedObject(self, (__bridge const void *)(mockObject));
    [mock registerInvocation:anInvocation];
	if([mock answerStubbedInvocation:anInvocation] == NO)
    {
        // if mock doesn't want to handle the invocation, maybe all expects have occurred, we forward to real object
        SEL originalSelector = [anInvocation selector];
        SEL aliasSelector = NSSelectorFromString([OCMRealMethodAliasPrefix stringByAppendingString:NSStringFromSelector(originalSelector)]);
        [anInvocation setSelector:aliasSelector];
        [anInvocation invoke];
        [anInvocation setSelector:originalSelector];
    }
}

// Make the compiler happy; we add a method with this name to the real class
- (Class)class_Original
{
    return nil;
}

// Implementation of the -class method; return the Class that was reported with [realObject class] prior to mocking
- (Class)classForRealObject
{
    // "self" is the real object, not the mock
    MKTPartialMock *mock = objc_getAssociatedObject(self, (__bridge const void *)(mockObject));
    if (mock != nil)
        return [mock spiedClass];
    
    return [self class_Original];
}

@end
