//  OCMockito by Jon Reid, https://qualitycoding.org
//  Copyright 2021 Quality Coding, Inc. See LICENSE.txt

#import <OCMockito/MKTBaseMockObject.h>


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Mock object implementing a given protocol.
 */
@interface MKTProtocolMock : MKTBaseMockObject

@property (nonatomic, strong, readonly) Protocol *mockedProtocol;

- (instancetype)initWithProtocol:(Protocol *)aProtocol
          includeOptionalMethods:(BOOL)includeOptionalMethods NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
