//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "MKTInvocationContainer.h"

#import "MKTStubbedInvocationMatcher.h"
#import "NSInvocation+OCMockito.h"
#import "MKTInvocation.h"


@interface MKTInvocationContainer ()
@property (nonatomic, strong, readonly) NSMutableArray<MKTInvocation *> *mutableRegisteredInvocations;
@property (nonatomic, strong) MKTStubbedInvocationMatcher *invocationForStubbing;
@property (nonatomic, strong, readonly) NSMutableArray<MKTStubbedInvocationMatcher *> *stubbed;
@end

@implementation MKTInvocationContainer


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _mutableRegisteredInvocations = [[NSMutableArray alloc] init];
        _stubbed = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray<MKTInvocation *> *)registeredInvocations
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

- (BOOL)isStubbingCopyMethod
{
    return self.registeredInvocations.count > 0 &&
            [self.registeredInvocations[0] invocation].selector == @selector(copy);
}

@end
