Pod::Spec.new do |s|
  s.name     = 'OCMockito'
  s.version  = '7.0.2'
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
  s.social_media_url = 'https://iosdev.space/@qcoding'

  s.osx.deployment_target = '10.13'
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '2.0'
  s.visionos.deployment_target = '1.0'
  s.source   = { :git => 'https://github.com/jonreid/OCMockito.git', :tag => 'v7.0.2' }
  s.source_files = 'Sources/OCMockito/**/*.{h,m}', 'Sources/ThirdParty/**/*.{h,m}'
  s.public_header_files = 'Sources/OCMockito/Core/MKTNonObjectArgumentMatching.h',  'Sources/OCMockito/Core/OCMockito.h',  'Sources/OCMockito/Invocation/NSInvocation+OCMockito.h',  'Sources/OCMockito/Mocking/MKTBaseMockObject.h',  'Sources/OCMockito/Mocking/MKTClassObjectMock.h',  'Sources/OCMockito/Mocking/MKTObjectAndProtocolMock.h',  'Sources/OCMockito/Mocking/MKTObjectMock.h',  'Sources/OCMockito/Mocking/MKTProtocolMock.h',  'Sources/OCMockito/Stubbing/MKTOngoingStubbing.h'
  s.requires_arc = true
  s.dependency 'OCHamcrest', '~> 9.1.1'
end
