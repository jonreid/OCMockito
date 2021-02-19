Pod::Spec.new do |s|
  s.name     = 'OCMockito'
  s.version  = '6.0.0'
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
  s.license  = { :type => 'MIT' }
  s.author   = { 'Jon Reid' => 'jon@qualitycoding.org' }
  s.social_media_url = 'https://twitter.com/qcoding'
    
  s.osx.deployment_target = '10.10'
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.source   = { :git => 'https://github.com/jonreid/OCMockito.git', :tag => 'v6.0.0' }
  s.source_files = 'Source/OCMockito/**/*.{h,m}', 'Source/ThirdParty/**/*.{h,m}'
  s.public_header_files = 'Source/OCMockito/Core/MKTNonObjectArgumentMatching.h',  'Source/OCMockito/Core/OCMockito.h',  'Source/OCMockito/Invocation/NSInvocation+OCMockito.h',  'Source/OCMockito/Mocking/MKTBaseMockObject.h',  'Source/OCMockito/Mocking/MKTClassObjectMock.h',  'Source/OCMockito/Mocking/MKTObjectAndProtocolMock.h',  'Source/OCMockito/Mocking/MKTObjectMock.h',  'Source/OCMockito/Mocking/MKTProtocolMock.h',  'Source/OCMockito/Stubbing/MKTOngoingStubbing.h'
  s.requires_arc = true
  s.dependency 'OCHamcrest', '~> 8.0'
end
