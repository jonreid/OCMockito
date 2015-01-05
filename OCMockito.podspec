Pod::Spec.new do |s|
  s.name     = 'OCMockito'
  s.version  = '1.4.0'
  s.summary  = 'OCMockito is an Objective-C implementation of Mockito, supporting creation, verification and stubbing of mock objects.'
  s.description = <<-DESC
                    OCMockito is an Objective-C implementation of Mockito, supporting creation, 
                    verification and stubbing of mock objects.

                    Key differences from other mocking frameworks:

                    * Mock objects are always "nice," recording their calls instead of 
                      throwing exceptions about unspecified invocations. This makes tests less fragile.
                    * No expect-run-verify, making tests more readable. Mock objects 
                      record their calls, then you verify the methods you want.
                    * Verification failures are reported as unit test failures, 
                      identifying specific lines instead of throwing exceptions. This makes 
                      it easier to identify failures.
                  DESC
  s.homepage = 'https://github.com/jonreid/OCMockito'
  s.license  = 'MIT'
  s.author   = { 'Jon Reid' => 'jon@qualitycoding.org' }
  s.social_media_url = 'https://twitter.com/qcoding'
    
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.source   = { :git => 'https://github.com/jonreid/OCMockito.git', :tag => 'v1.4.0' }
  s.source_files = 'Source/OCMockito/OCMockito.h', 'Source/OCMockito/**/*.{h,m}', 'Source/ThirdParty/**/*.{h,m}'
  s.public_header_files = 'Source/OCMockito/OCMockito.h', 'Source/OCMockito/MKTArgumentCaptor.h', 'Source/OCMockito/MKTBaseMockObject.h', 'Source/OCMockito/MKTClassObjectMock.h', 'Source/OCMockito/MKTObjectMock.h', 'Source/OCMockito/MKTObjectAndProtocolMock.h', 'Source/OCMockito/MKTProtocolMock.h', 'Source/OCMockito/MKTOngoingStubbing.h', 'Source/OCMockito/MKTPrimitiveArgumentMatching.h', 'Source/OCMockito/NSInvocation+OCMockito.h'
  s.requires_arc = true
  s.dependency 'OCHamcrest', '~> 4.0'
end