Compatibility-breaking change
-------------

OCMockito now requires OCHamcrest v5.1.0 or higher, which also potentially breaks compatibility.

**Features:**

- Instead of enabling short syntax by defining MOCKITO_SHORTHAND, short syntax is now enabled by
  default. To disable it, #define MKT_DISABLE_SHORT_SYNTAX.
- More detailed failure information, including stack trace relevant to the unmet expectation.

**Fixes:**

- Fixed `atMost(0)`

**Deleted:**

- `MKTCapturingMatcher` (deprecated in 2.0.1)


Version 2.0.3
-------------
_06 Nov 2015_

**Project changes:**

- Enabling "Symbols hidden by default" in 2.0.2 was overkill, preventing people from using the
  prebuilt Mac framework.


Version 2.0.2
-------------
_24 Oct 2015_

**Project changes:**

- Remove debug symbols from Release configuration, which bloated the libraries and kept folks from
  using the prebuilt iOS framework.


Version 2.0.1
-------------
_14 Oct 2015_

**Compatibility-breaking Change:**

- Eliminated `reset(mock)` since `reset` was likely to clash with mocked methods. Call
  `stopMocking(mock)` instead.

**Fixes:**

- Fixed crash when multiple mock objects are at play on multiple threads.

**Features:**

- Stub void methods with `givenVoid(…)`. _Thanks to: Lysann Schlegel_
- Added `atMost(count)` for `verifyCount()`. _Thanks to: Emile Cantin_

**Improvements:**

- Use `stopMocking(…)` if a `-dealloc` of your System Under Test is trying to message an object that
  is mocked. It disables message handling on the mock and frees its retained arguments. This
  prevents retain cycles and crashes during test clean-up. See StopMockingTests.m for an example.
- NSInvocation+OCMockito.h is now imported by OCMockito.h, so it no longer needs a separate import.

**Deprecated:**

- Deprecated MKTCapturingMatcher; use HCArgumentCaptor from OCHamcrest for capturing arguments.
  There is no need to call -capture to get a matcher to use as the argument, since HCArgumentCaptor
  is a matcher.

**Project changes:**

- Updated project settings to Xcode 7, with tests now run by XCTest.


Version 1.4.0
-------------
_04 Jan 2015_

**Features:**

- Stub sequential returns by chaining `willReturn:`.
- Stub throwing exceptions with `willThrow:`.
- Stub execution of a block with `willDo:`.
- Added support for dynamic properties. _Thanks to Eugen Martynov for example code_
- Added `mockProtocolWithoutOptionals(…)` which mocks an object implementing a given protocol, but
  without mocking any optional methods. _Thanks to: Paweł Dudek_

**Improvements:**

- Updated project to make it run-path dependent.


Version 1.3.1
-------------
_27 Sep 2014_

TPWeakProxy changes:

- Updated to from TPWeakProxy to TPDWeakProxy.
- Directly include a renamed copy to simplify non-CocoaPod builds. Don't call the script
  Frameworks/getweakproxy anymore.


Version 1.3.0
-------------
_04 Jun 2014_

This version requires OCHamcrest 4.0.1.
TPWeakProxy 1.0.0 is also needed to build OCMockito.

- To build OCMockito without CocoaPods, execute two scripts:
  * Frameworks/gethamcrest
  * Frameworks/getweakproxy

**Fixes:**

- Fix `mockClass` crash on 64-bit runtime (OS X and iOS).
- Fixed retain cycle between mocks and tests. The fix addresses most but not all cases. If the
  `-dealloc` of your System Under Test is not called when you nil out your SUT, call `-reset` on
  your mock object (probably from `tearDown`). _Thanks to ronak2121 for testing_

**Features:**

- Stub methods that return structs with `willReturnStruct:objCType:`. _Thanks to
  GWStuartClift and Yaron Inger_
- `stubProperty(instance, property, value)` stubs a property, and its related
  `getValueForKey:` and `valueForKeyPath:` KVO methods. _Thanks to: Sasha Zats_

**Project changes:**

- Increased deployment targets to OS X 10.8, iOS 6.0.


Version 1.2.0
-------------
_05 Apr 2014_

If you're not using CocoaPods, please specify `-ObjC` in your "Other Linker Flags".

**Fixes:**

- Fix crash capturing nil selectors as method parameters. _Thanks to: Sergio Padrino_
- Fix crash capturing inline blocks as method parameters. _Thanks to: Sergio Padrino_
- Fix crash returning BOOL on 64-bit iOS. _Thanks to: Ullrich Schäfer_

**Features:**

- Added support for pointer arguments, including `NSError **`.
- Added support for struct arguments. _Thanks to: César Estébanez Tascón_

**Improvements:**

- To build OCMockito without CocoaPods, execute the script Frameworks/gethamcrest first to get the
  latest OCHamcrest release.


Version 1.1.0
-------------
_30 Oct 2013_

**Features:**

- Added MKTArgumentCaptor to capture arguments:
  * Use `capture` to capture the argument. This must be used inside of
    verification.
  * Use `value` to return the captured value.
  * Use `allValues` to return an array of all captured values.

**Improvements:**

- Changed mock object factory methods to cast to `(id)` to eliminate AppCode warnings.
- Added support for 64-bit iOS devices.
- Convert primitive arguments to objects using NSInvocation+OCMockito by Taras
  Kalapun.

**Examples & Documentation:**

- Updated examples so they are based on Apple's templates for main target vs. test target. Added
  CocoaPods examples.
- Eliminated DocSet. Documentation will be in the main README and in the OCMockito wiki,
  https://github.com/jonreid/OCMockito/wiki/_pages


Version 1.0.0
-------------
_06 Sep 2013_

This release adopts Semantic Versioning (http://semver.org). _Thanks to: Jens Nerup_

**New dependencies:**

- Requires OCHamcrest 3.0.0.

**Features:**

- Added support for XCTest. _Special thanks to Richard Clem for testing_
- Added ability to match block arguments. Supported matchers:
  * `anything()`
  * `nilValue()`
  * `notNilValue()`
  * `sameInstance()`
- Added `-description` to mock objects to help when debugging.


Version 0.23
------------
_23 Nov 2012_

- Added `atLeast(count)` and `atLeastOnce()` for `verifyCount()`. _Thanks to: Markus Gasser_
- Handle Class as both argument type and return type. _Thanks to: David Hart_
- Added support for `-isKindOfClass:` to object mocks. _Thanks to: Tim Pesce_
- No more need to specify "Other Linker Flags"! Depending on your project, you may be able to
  eliminate:
  * `-lstdc++`
  * `-ObjC`
* Converted source, tests, and examples to ARC


Version 0.22
------------
_18 Mar 2012_

- Added `mockClass(…)` which mocks a class object. _Thanks to: David Hart_
- Added `mockObjectAndProtocol(Class, Protocol)` which mocks an object of a given class that also
  implements a given protocol. _Thanks to: Kevin Lundberg_


Version 0.21
------------
_09 Mar 2012_

- Added `mockProtocol(…)` which mocks an object implementing a given protocol.
- `given(…)` now supports methods returning float or double. _Thanks to: Markus Gasser_
* `verify(…)` and `verifyCount(…)` check that argument is a mock object.
* Eliminated `givenPreviousCall`.
* Changed build configuration to Debug during initial development.


Version 0.1
-----------
_24 Nov 2011 prerelease_
