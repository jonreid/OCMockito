//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import "OCMockito.h"

#import <OCHamcrest/OCHamcrest.h>
@import XCTest;


@interface CopyingClass : NSObject
@property (nonatomic, copy, readonly) NSURL *url;
- (instancetype)initWithURL:(NSURL *)url;
@end

@implementation CopyingClass

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self)
        _url = [url copy];
    return self;
}

@end


@interface StubbingCopyTests : XCTestCase
@end

@implementation StubbingCopyTests

- (void)testCopyingWithCopyExpectation
{
    NSURL *mockUrl = mock([NSURL class]);
    [given([mockUrl copy]) willReturn:mockUrl];
    
    CopyingClass *copyingClass = [[CopyingClass alloc] initWithURL:mockUrl];
    
    assertThat(copyingClass.url, is(sameInstance(mockUrl)));
}

@end
