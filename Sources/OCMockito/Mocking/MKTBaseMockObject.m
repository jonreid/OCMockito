// OCMockito by Jon Reid, https://qualitycoding.org
// Copyright 2011 Jonathan M. Reid. https://github.com/jonreid/OCMockito/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

#import "MKTBaseMockObject.h"

#import "MKTInvocationContainer.h"
#import "MKTInvocationMatcher.h"
#import "MKTMockingProgress.h"
#import "MKTOngoingStubbing.h"
#import "MKTStubbedInvocationMatcher.h"
#import "MKTVerificationData.h"
#import "MKTVerificationMode.h"
#import "NSInvocation+OCMockito.h"


@interface MKTBaseMockObject ()
@property (nonatomic, strong, readonly) MKTMockingProgress *mockingProgress;
@property (nonatomic, strong) MKTInvocationContainer *invocationContainer;
@property (nonatomic, assign) BOOL stoppedMocking;
@end

@implementation MKTBaseMockObject

+ (BOOL)isMockObject:(nullable id)object
{
    NSString *className = NSStringFromClass([object class]);
    return [className isEqualToString:@"MKTObjectMock"] ||
            [className isEqualToString:@"MKTProtocolMock"] ||
            [className isEqualToString:@"MKTClassObjectMock"] ||
            [className isEqualToString:@"MKTObjectAndProtocolMock"];
}

- (instancetype)init
{
    if (self)
    {
        _mockingProgress = [MKTMockingProgress sharedProgress];
        _invocationContainer = [[MKTInvocationContainer alloc] init];
    }
    return self;
}

- (void)stopMocking
{
    self.stoppedMocking = YES;
    self.invocationContainer = nil;
    [self.mockingProgress reset];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (self.stoppedMocking)
        return;
    if ([self handlingVerifyOfInvocation:invocation])
        return;

    @synchronized (self)
    {
        [self prepareInvocationForStubbing:invocation];
        [self answerInvocation:invocation];
    }
}

- (BOOL)handlingVerifyOfInvocation:(NSInvocation *)invocation
{
    id <MKTVerificationMode> verificationMode = [self.mockingProgress pullVerificationModeWithMock:self];
    if (verificationMode)
        [self verifyInvocation:invocation usingVerificationMode:verificationMode];
    return verificationMode != nil;
 }

- (void)verifyInvocation:(NSInvocation *)invocation usingVerificationMode:(id <MKTVerificationMode>)verificationMode
{
    MKTInvocationMatcher *invocationMatcher = [self matcherWithInvocation:invocation];
    MKTVerificationData *data = [self verificationDataWithMatcher:invocationMatcher];
    [verificationMode verifyData:data testLocation:self.mockingProgress.testLocation];
}

- (MKTInvocationMatcher *)matcherWithInvocation:(NSInvocation *)invocation
{
    MKTInvocationMatcher *invocationMatcher = [self.mockingProgress pullInvocationMatcher];
    if (!invocationMatcher)
        invocationMatcher = [[MKTInvocationMatcher alloc] init];
    [invocationMatcher setExpectedInvocation:invocation];
    return invocationMatcher;
}

- (MKTVerificationData *)verificationDataWithMatcher:(MKTInvocationMatcher *)invocationMatcher
{
    return [[MKTVerificationData alloc] initWithInvocationContainer:self.invocationContainer
                                                  invocationMatcher:invocationMatcher];
}

- (void)prepareInvocationForStubbing:(NSInvocation *)invocation
{
    [self.invocationContainer setInvocationForPotentialStubbing:invocation];
    MKTOngoingStubbing *ongoingStubbing =
            [[MKTOngoingStubbing alloc] initWithInvocationContainer:self.invocationContainer];
    [self.mockingProgress reportOngoingStubbing:ongoingStubbing];
}

- (void)answerInvocation:(NSInvocation *)invocation
{
    MKTStubbedInvocationMatcher *stubbedInvocation = [self.invocationContainer findAnswerFor:invocation];
    if (stubbedInvocation)
        [self useExistingAnswerInStub:stubbedInvocation forInvocation:invocation];
}

- (void)useExistingAnswerInStub:(MKTStubbedInvocationMatcher *)stub forInvocation:(NSInvocation *)invocation
{
    [invocation mkt_setReturnValue:[stub answerInvocation:invocation]];
}


#pragma mark - MKTNonObjectArgumentMatching

- (id)withMatcher:(id <HCMatcher>)matcher forArgument:(NSUInteger)index
{
    [self.mockingProgress setMatcher:matcher forArgument:index];
    return self;
}

- (id)withMatcher:(id <HCMatcher>)matcher
{
    return [self withMatcher:matcher forArgument:0];
}

@end
