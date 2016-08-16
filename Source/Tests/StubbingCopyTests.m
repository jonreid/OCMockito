//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
#import <XCTest/XCTest.h>

@interface InjectedClass : NSObject
+ (id)alloccurrences;
+ (id)newspaper;
- (id)alloccurrences;
- (id)newspaper;
- (id)copyThisObject;
- (id)mutableCopyThisObject;
@end

@implementation InjectedClass

+ (id)alloccurrences
{
    return [self new];
}

+ (id)newspaper
{
    return [self new];
}

- (id)alloccurrences
{
    return self;
}

- (id)newspaper
{
    return self;
}

- (id)copyThisObject
{
    return [self copy];
}

- (id)mutableCopyThisObject
{
    return [self mutableCopy];
}

@end


@interface InjectingClass : NSObject
@property (nonatomic, copy, readonly) InjectingClass *response1;
@property (nonatomic, copy, readonly) InjectingClass *response2;
@property (nonatomic, copy, readonly) InjectingClass *response3;
@property (nonatomic, copy, readonly) InjectingClass *response4;
@property (nonatomic, copy, readonly) InjectingClass *response5;
@property (nonatomic, copy, readonly) InjectingClass *response6;
@property (nonatomic, copy, readonly) InjectingClass *response7;
@property (nonatomic, copy, readonly) InjectingClass *response8;
- (instancetype)initWithInjectedClass:(InjectedClass *)injectedClass;
@end

@implementation InjectingClass

- (instancetype)initWithInjectedClass:(InjectedClass *)injectedClass
{
    self = [super init];
    if (self) {
        _response1 = [InjectedClass alloccurrences];
        _response2 = [InjectedClass newspaper];
        _response3 = [injectedClass alloccurrences];
        _response4 = [injectedClass newspaper];
        _response5 = [injectedClass copy];
        _response6 = [injectedClass copyThisObject];
        _response7 = [injectedClass mutableCopy];
        _response8 = [injectedClass mutableCopyThisObject];
    }

    return self;
}

@end


@interface StubbingOwnedObjectMethodTests : XCTestCase
@end

@implementation StubbingOwnedObjectMethodTests

- (void)testOwnedObjectInstanceMethods
{
    @autoreleasepool {
        InjectedClass *objectMock = mock([InjectedClass class]);
        [given([objectMock alloccurrences]) willReturn:objectMock];
        [given([objectMock newspaper]) willReturn:objectMock];
        [given([objectMock copy]) willReturn:objectMock];
        [given([objectMock copyThisObject]) willReturn:objectMock];
        [given([objectMock mutableCopy]) willReturn:objectMock];
        [given([objectMock mutableCopyThisObject]) willReturn:objectMock];
        
        __strong Class classMock = mockClass([InjectedClass class]);
        stubSingleton(classMock, alloccurrences);
        stubSingleton(classMock, newspaper);
        [given ([InjectedClass alloccurrences]) willReturn:objectMock];
        [given ([InjectedClass newspaper]) willReturn:objectMock];

        InjectingClass *codeUnderTest = [[InjectingClass alloc] initWithInjectedClass:objectMock];
        
        assertThat(codeUnderTest.response1, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response2, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response3, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response4, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response5, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response6, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response7, is(sameInstance(objectMock)));
        assertThat(codeUnderTest.response8, is(sameInstance(objectMock)));
        
        stopMocking(objectMock);
    }
}

@end
