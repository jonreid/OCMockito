Version 1.0.0
=============
_06 Sep 2013_

This release adopts Semantic Versioning (http://semver.org). _Thanks to: Jens Nerup_

**New dependency:**

- Requires OCHamcrest 3.0.0.

**Features:**

- Added support for XCTest. _Special thanks to Richard Clem for testing_
- Added ability to match block arguments. Supported matchers:
  * ``anything()``
  * ``nilValue()``
  * ``notNilValue()``
- Added ``-description`` to mock objects to help when debugging.


Version 0.23
============
_23 Nov 2012_

- Added ``atLeast(count)`` and ``atLeastOnce()`` for ``verifyCount()``. _Thanks to: Markus Gasser_
- Handle Class as both argument type and return type. _Thanks to: David Hart_
- Added support for ``-isKindOfClass:`` to object mocks. _Thanks to: Tim Pesce_
- No more need to specify "Other Linker Flags"! Depending on your project, you may be able to
  eliminate:
  * ``-lstdc++``
  * ``-ObjC``
* Converted source, tests, and examples to ARC


Version 0.22
============
_18 Mar 2012_

- Added ``mockClass(…)`` which mocks a class object. _Thanks to: David Hart_
- Added ``mockObjectAndProtocol(Class, Protocol)`` which mocks an object of a given class that also
  implements a given protocol. _Thanks to: Kevin Lundberg_


Version 0.21
============
_09 Mar 2012_

- Added ``mockProtocol(…)`` which mocks an object implementing a given protocol.
- ``given(…)`` now supports methods returning float or double. _Thanks to: Markus Gasser_
* ``verify(…)`` and ``verifyCount(…)`` check that argument is a mock object.
* Eliminated ``givenPreviousCall``.
* Changed build configuration to Debug during initial development.


Version 0.1
===========
_24 Nov 2011 prerelease_
