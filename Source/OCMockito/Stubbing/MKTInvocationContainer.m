//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationContainer.h"

#import "MKTStubbedInvocationMatcher.h"
#import "NSInvocation+OCMockito.h"
#import "MKTInvocation.h"


@interface MKTInvocationContainer ()
@property (nonatomic, strong, readonly) NSMutableArray *mutableRegisteredInvocations;
@property (nonatomic, strong) MKTStubbedInvocationMatcher *invocationForStubbing;
@property (nonatomic, strong, readonly) NSMutableArray *stubbed;
@property (nonatomic, strong, readonly) NSArray *ownedObjectMethodPrefixes;
@end

@implementation MKTInvocationContainer


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mutableRegisteredInvocations = [[NSMutableArray alloc] init];
        _stubbed = [[NSMutableArray alloc] init];
        _ownedObjectMethodPrefixes = @[
                                       NSStringFromSelector(@selector(alloc)),
                                       NSStringFromSelector(@selector(new)),
                                       NSStringFromSelector(@selector(copy)),
                                       NSStringFromSelector(@selector(mutableCopy)),
                                       ];
    }
    return self;
}

- (NSArray *)registeredInvocations
{
    return self.mutableRegisteredInvocations;
}

- (void)setInvocationForPotentialStubbing:(NSInvocation *)invocation
{
    [invocation mkt_retainArgumentsWithWeakTarget];
    MKTInvocation *wrappedInvocation = [[MKTInvocation alloc] initWithInvocation:invocation];
    [self.mutableRegisteredInvocations addObject:wrappedInvocation];

    MKTStubbedInvocationMatcher *s = [[MKTStubbedInvocationMatcher alloc] init];
    [s setExpectedInvocation:invocation];
    self.invocationForStubbing = s;
}

- (void)setMatcher:(id <HCMatcher>)matcher atIndex:(NSUInteger)argumentIndex
{
    [self.invocationForStubbing setMatcher:matcher atIndex:argumentIndex];
}

- (void)addAnswer:(id <MKTAnswer>)answer
{
    [self.mutableRegisteredInvocations removeLastObject];

    [self.invocationForStubbing addAnswer:answer];
    [self.stubbed insertObject:self.invocationForStubbing atIndex:0];
}

- (MKTStubbedInvocationMatcher *)findAnswerFor:(NSInvocation *)invocation
{
    for (MKTStubbedInvocationMatcher *s in self.stubbed)
        if ([s matches:invocation])
            return s;
    return nil;
}

- (BOOL)isStubbingOwnedObjectMethod
{
    NSInvocation *invocation = [self.registeredInvocations.firstObject invocation];
    SEL selector = invocation.selector;
    if (selector == 0) {
        return NO;
    }

    NSString *selectorName = NSStringFromSelector(selector);
    for (NSString *ownedObjectMethodPrefix in self.ownedObjectMethodPrefixes) {
        if ([selectorName hasPrefix:ownedObjectMethodPrefix]) {
            return YES;
        }
    }
    
    return NO;
}

@end
