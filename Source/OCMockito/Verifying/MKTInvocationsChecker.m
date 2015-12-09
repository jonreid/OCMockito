#import "MKTNumberOfInvocationsChecker.h"

#import "MKTFilterCallStack.h"
#import "MKTParseCallStack.h"
#import "MKTMatchingInvocationsFinder.h"


@interface MKTInvocationsChecker ()
@property (nonatomic, copy) NSString *wantedDescription;
@end

@implementation MKTInvocationsChecker

- (instancetype)initWithWantedDescription:(NSString *)wantedDescription
{
    self = [super init];
    if (self)
        self.wantedDescription = [wantedDescription copy];
    return self;
}

- (MKTMatchingInvocationsFinder *)invocationsFinder
{
    if (!_invocationsFinder) {
        _invocationsFinder = [[MKTMatchingInvocationsFinder alloc] init];
    }
    return _invocationsFinder;
}

- (NSString *)tooLittleActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount
{
    NSString *problem = [self describeWanted:wantedCount butWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfLastInvocation];
    return [self joinProblem:problem callStack:callStack label:@"Last invocation:"];
}

- (NSString *)tooManyActual:(NSUInteger)actualCount wantedCount:(NSUInteger)wantedCount
{
    NSString *problem = [self describeWanted:wantedCount butWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfInvocationAtIndex:wantedCount];
    return [self joinProblem:problem callStack:callStack label:@"Undesired invocation:"];
}

- (NSString *)neverWantedButActual:(NSUInteger)actualCount
{
    NSString *problem = [self describeNeverWantedButWasCalled:actualCount];
    NSArray *callStack = [self.invocationsFinder callStackOfInvocationAtIndex:0];
    return [self joinProblem:problem callStack:callStack label:@"Undesired invocation:"];
}

- (NSString *)describeWanted:(NSUInteger)wantedCount butWasCalled:(NSUInteger)actualCount
{
    return [NSString stringWithFormat:@"%@ %@ but was called %@.",
                                      [self wantedDescription],
                                      [self pluralizeTimes:wantedCount],
                                      [self pluralizeTimes:actualCount]];
}

- (NSString *)describeNeverWantedButWasCalled:(NSUInteger)actualCount
{
    return [NSString stringWithFormat:@"Never wanted but was called %@.",
                                      [self pluralizeTimes:actualCount]];
}

- (NSString *)pluralizeTimes:(NSUInteger)count
{
    return count == 1 ? @"1 time" : [NSString stringWithFormat:@"%lu times", (unsigned long)count];
}

- (NSString *)joinProblem:(NSString *)problem callStack:(NSArray *)callStack label:(NSString *)label
{
    if (!callStack)
        return problem;
    else
    {
        NSString *report = [problem stringByAppendingFormat:@" %@\n", label];
        return [report stringByAppendingString:[self reportCallStack:callStack]];
    }
}

- (NSString *)reportCallStack:(NSArray *)callStack
{
    NSArray *stack = MKTFilterCallStack(MKTParseCallStack(callStack));
    return [stack componentsJoinedByString:@"\n"];
}

@end
