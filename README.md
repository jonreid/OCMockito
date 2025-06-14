![mockito](https://raw.githubusercontent.com/mockito/mockito.github.io/master/img/logo.png)

# OCMockito

[![Build Status](https://github.com/jonreid/OCMockito/actions/workflows/build.yml/badge.svg)](https://github.com/jonreid/OCMockito/actions/workflows/build.yml)
[![Coverage Status](https://coveralls.io/repos/jonreid/OCMockito/badge.svg)](https://coveralls.io/r/jonreid/OCMockito)
[![Swift Package Index Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjonreid%2FOCMockito%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/jonreid/OCMockito)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/OCMockito.svg?style=flat)](https://cocoapods.org/pods/OCMockito)

OCMockito is an Objective-C implementation of Mockito, supporting creation,
verification and stubbing of mock objects.

Key differences from other mocking frameworks:

* Mock objects are always "nice," recording their calls instead of throwing
  exceptions about unspecified invocations. This makes tests less fragile.

* No expect-run-verify, making tests more readable. Mock objects record their
  calls, then you verify the methods you want.

* Verification failures are reported as unit test failures, identifying specific
  lines instead of throwing exceptions. This makes it easier to identify
  failures.

<!-- toc -->
## Contents

  * [Let's verify some behavior!](#lets-verify-some-behavior)
  * [How about some stubbing?](#how-about-some-stubbing)
  * [How do you mock a class object?](#how-do-you-mock-a-class-object)
  * [How do you mock a protocol?](#how-do-you-mock-a-protocol)
  * [How do you mock an object that also implements a protocol?](#how-do-you-mock-an-object-that-also-implements-a-protocol)
  * [How do you stub methods that return primitives?](#how-do-you-stub-methods-that-return-primitives)
  * [How do you stub methods that return structs?](#how-do-you-stub-methods-that-return-structs)
  * [How do you stub a property so that KVO works?](#how-do-you-stub-a-property-so-that-kvo-works)
  * [Argument matchers](#argument-matchers)
  * [How do you specify matchers for non-object arguments?](#how-do-you-specify-matchers-for-non-object-arguments)
  * [Verifying exact number of invocations / at least x / never](#verifying-exact-number-of-invocations--at-least-x--never)
  * [Capturing arguments for further assertions](#capturing-arguments-for-further-assertions)
  * [Stubbing consecutive calls](#stubbing-consecutive-calls)
  * [Stubbing with blocks](#stubbing-with-blocks)
  * [Problems with dealloc](#problems-with-dealloc)
  * [How do you mock a singleton?](#how-do-you-mock-a-singleton)
  * [How do I add OCMockito to my project?](#how-do-i-add-ocmockito-to-my-project)
    * [Swift Package Manager](#swift-package-manager)
    * [CocoaPods](#cocoapods)
    * [Carthage](#carthage)
    * [Prebuilt Framework](#prebuilt-framework)
    * [Build Your Own](#build-your-own)
  * [Author](#author)<!-- endToc -->

## Let's verify some behavior!

```obj-c
// mock creation
NSMutableArray *mockArray = mock([NSMutableArray class]);

// using mock object
[mockArray addObject:@"one"];
[mockArray removeAllObjects];

// verification
[verify(mockArray) addObject:@"one"];
[verify(mockArray) removeAllObjects];
```

Once created, the mock will remember all interactions. Then you can selectively
verify whatever interactions you are interested in.

(If Xcode complains about multiple methods with the same name, cast `verify`
to the mocked class.)


## How about some stubbing?

```obj-c
// mock creation
NSArray *mockArray = mock([NSArray class]);

// stubbing
[given([mockArray objectAtIndex:0]) willReturn:@"first"];
[given([mockArray objectAtIndex:1]) willThrow:[NSException exceptionWithName:@"name"
                                                                      reason:@"reason"
                                                                    userInfo:nil]];

// following prints "first"
NSLog(@"%@", [mockArray objectAtIndex:0]);

// follows throws exception
NSLog(@"%@", [mockArray objectAtIndex:1]);

// following prints "(null)" because objectAtIndex:999 was not stubbed
NSLog(@"%@", [mockArray objectAtIndex:999]);
```


## How do you mock a class object?

```obj-c
__strong Class mockStringClass = mockClass([NSString class]);
```

(In the iOS 64-bit runtime, Class objects aren't strong by default. Either make
it explicitly strong as shown above, or use `id` instead.)


## How do you mock a protocol?

```obj-c
id <MyDelegate> delegate = mockProtocol(@protocol(MyDelegate));
```

Or, if you don't want it to contain any optional methods:

```obj-c
id <MyDelegate> delegate = mockProtocolWithoutOptionals(@protocol(MyDelegate));
```


## How do you mock an object that also implements a protocol?

```obj-c
UIViewController <CustomProtocol> *controller =
    mockObjectAndProtocol([UIViewController class], @protocol(CustomProtocol));
```


## How do you stub methods that return primitives?

To stub methods that return primitive scalars, box the scalars into NSValues:

```obj-c
[given([mockArray count]) willReturn:@3];
```


## How do you stub methods that return structs?

Use `willReturnStruct:objCType:` passing a pointer to your structure and its
type from the Objective-C `@encode()` compiler directive:

```obj-c
SomeStruct aStruct = {...};
[given([mockObject methodReturningStruct]) willReturnStruct:&aStruct
                                                   objCType:@encode(SomeStruct)];
```


## How do you stub a property so that KVO works?

Use `stubProperty(mock, property, stubbedValue)`. For example, say you have a
mock object named `mockEmployee`. It has a property `firstName`. You want to
stub it to return the value "FIRST-NAME":

```obj-c
stubProperty(mockEmployee, firstName, @"FIRST-NAME");
```

This stubs the `firstName` property, `valueForKey:` and `valueForKeyPath:`.


## Argument matchers

OCMockito verifies argument values by testing for equality. But when extra
flexibility is required, you can specify
 [OCHamcrest](https://github.com/hamcrest/OCHamcrest) matchers.

```obj-c
// mock creation
NSMutableArray *mockArray = mock([NSMutableArray class]);

// using mock object
[mockArray removeObject:@"This is a test"];

// verification
[verify(mockArray) removeObject:startsWith(@"This is")];
```

OCHamcrest matchers can be specified as arguments for both verification and
stubbing.

Typed arguments will issue a warning that the matcher is the wrong type. Just
cast the matcher to `id`.


## How do you specify matchers for non-object arguments?

To stub a method that takes a non-object argument but specify a matcher, invoke
the method with a dummy argument, then call `-withMatcher:forArgument:`

```obj-c
[[given([mockArray objectAtIndex:0]) withMatcher:anything() forArgument:0]
 willReturn:@"foo"];
```

This is particularly useful for ignoring `NSError **` parameters: pass in `NULL`, but override it with an `anything()` matcher.

Use the shortcut `-withMatcher:` to specify a matcher for a single argument:

```obj-c
[[given([mockArray objectAtIndex:0]) withMatcher:anything()]
 willReturn:@"foo"];
```

These methods are also available to specify matchers for verification. Just call
them after `verify(…)` but before the invocation you want to verify:

```obj-c
[[verify(mockArray) withMatcher:greaterThan(@5])] removeObjectAtIndex:0];
```


## Verifying exact number of invocations / at least x / never

```obj-c
// using mock
[mockArray addObject:@"once"];

[mockArray addObject:@"twice"];
[mockArray addObject:@"twice"];

// the following two verifications work exactly the same
[verify(mockArray) addObject:@"once"];
[verifyCount(mockArray, times(1)) addObject:@"once"];

// verify exact number of invocations
[verifyCount(mockArray, times(2)) addObject:@"twice"];
[verifyCount(mockArray, times(3)) addObject:@"three times"];

// verify using never(), which is an alias for times(0)
[verifyCount(mockArray, never()) addObject:@"never happened"];

// verify using atLeast()/atMost()
[verifyCount(mockArray, atLeastOnce()) addObject:@"at least once"];
[verifyCount(mockArray, atLeast(2)) addObject:@"at least twice"];
[verifyCount(mockArray, atMost(5)) addObject:@"at most five times"];
```


## Capturing arguments for further assertions

OCMockito verifies argument values using OCHamcrest matchers; non-matcher
arguments are implicitly wrapped in the `equalTo` matcher to test for equality.
In some situations though, it's helpful to capture an argument so you can send
it another message.

OCHamcrest provides a special matcher for this purpose: HCArgumentCaptor.
Specify it as an argument, then query it with either the `value` or `allValues`
properties.

For example, you may want to send the captured argument a message to query its
state:

```obj-c
HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
[verify(mockObject) doSomething:(id)argument];
assertThat([argument.value nameAtIndex:0], is(@"Jon"));
```

Capturing arguments is especially handy for block arguments. Capture the
argument, cast it to the block type, then invoke the block directly to simulate
the ways it will be called by production code:

```obj-c
HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
[verify(mockArray) sortUsingComparator:(id)argument];
NSComparator block = argument.value;
assertThat(@(block(@"a", @"z")), is(@(NSOrderedAscending)));
```


## Stubbing consecutive calls

```obj-c
[[given([mockObject someMethod:@"some arg"])
    willThrow:[NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil]]
    willReturn:@"foo"];

// First call: throws exception
[mockObject someMethod:@"some arg"];

// Second call: prints "foo"
NSLog(@"%@", [mockObject someMethod:@"some arg"]);

// Any consecutive call: prints "foo" as well. (Last stubbing wins.)
NSLog(@"%@", [mockObject someMethod:@"some arg"]);
```


## Stubbing with blocks

We recommend using simple stubbing with `willReturn:` or `willThrow:` only. But
`willDo:` using a block can sometimes be helpful. The block can easily access
invocation arguments by calling `mkt_arguments` from NSInvocation+OCMockito.h.
Whatever the block returns will be used as the stubbed return value.

```obj-c
[given([mockObject someMethod:anything()]) willDo:^id (NSInvocation *invocation){
    NSArray *args = [invocation mkt_arguments];
    return @([args[0] intValue] * 2);
}];

// Following prints 4
NSLog(@"%@", [mockObject someMethod:@2]);
```

You can stub a void method with a block by using `givenVoid` instead of `given`.


## Problems with dealloc

Use `stopMocking(…)` if a `-dealloc` of your System Under Test is trying to
message an object that is mocked. It disables message handling on the mock and
frees its retained arguments. This prevents retain cycles and crashes during
test clean-up. See StopMockingTests.m for an example.


## How do you mock a singleton?

The short answer is: Don't. Instead of your class deciding who it's going to
talk to, inject those dependencies.

The longer answer is: Well. Legacy code. Call `stubSingleton` on a mock class
object, specifying the name of the factory method.

```obj-c
__strong Class mockUserDefaultsClass = mockClass([NSUserDefaults class]);
NSUserDefaults* mockDefaults = mock([NSUserDefaults class]);

stubSingleton(mockUserDefaultsClass, standardUserDefaults);
[given([NSUserDefaults standardUserDefaults]) willReturn:mockDefaults];
```

Beware! This uses swizzling. You need to make sure the mock class object gets
deallocated so that the swizzling is undone.

In the example above, `mockUserDefaultsClass` will go out scope and be
destroyed. But what if you kept it in the test fixture, as an ivar or a
property? According to XCTest's design, it won't be implicitly destroyed.
You need to explicitly set it to nil in `-tearDown`, or the swizzling will
bleed over to your other tests, compromising their integrity.

If you need more control over when the swizzling is undone, call
`stopMocking(…)` on the mock class.


## How do I add OCMockito to my project?

The [Examples](https://github.com/jonreid/OCMockito/tree/main/Examples) folder shows projects
ready to use OCMockito via Swift Package Manager, CocoaPods, or through the prebuilt framework.

### Swift Package Manager

Include an OCMockito package in your Package.swift manifest's array of `dependencies`:

<!-- snippet: swiftpm-declare-dependencies -->
<a id='snippet-swiftpm-declare-dependencies'></a>
```swift
dependencies: [
    .package(
        url: "https://github.com/jonreid/OCMockito",
        .upToNextMajor(from: "7.0.0")
    ),
],
```
<sup><a href='/Examples/MacExample-SwiftPackageManager/Package.swift#L13-L20' title='Snippet source file'>snippet source</a> | <a href='#snippet-swiftpm-declare-dependencies' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

Then add OCMockito to the dependencies of your `.testTarget`:

<!-- snippet: swiftpm-use-dependencies -->
<a id='snippet-swiftpm-use-dependencies'></a>
```swift
.testTarget(
    name: "ExampleTests",
    dependencies: [
        "Example",
        "OCMockito",
    ]
),
```
<sup><a href='/Examples/MacExample-SwiftPackageManager/Package.swift#L27-L35' title='Snippet source file'>snippet source</a> | <a href='#snippet-swiftpm-use-dependencies' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### CocoaPods

If you want to add OCMockito using Cocoapods then add the following dependency
to your Podfile. Most people will want OCMockito in their test targets, and not
include any pods from their main targets:

```ruby
target 'MyTests' do
  inherit! :search_paths
  use_frameworks!
  pod 'OCMockito', '~> 7.0'
end
```

### Carthage

Add the following to your Cartfile:

```
github "jonreid/OCMockito" ~> 7.0
```

Then drag the the built frameworks (both OCHamcrest and OCMockito) from the
appropriate Carthage/Build directory into your project, but with "Copy items
into destination group's folder" disabled.

### Prebuilt Framework

A prebuilt binary is available on GitHub for
[OCMockito](https://github.com/jonreid/OCMockito/releases/). You will also need
[OCHamcrest](https://github.com/hamcrest/OCHamcrest/releases/).
The binary is packaged as OCMockito.xcframework, containing these architectures:
* macOS
* Mac Catalyst
* iOS device
* iOS simulator
* tvOS device
* tvOS simulator
* visionOS device
* visionOS simulator
* watchOS device
* watchOS simulator

Drag the XCFramework into your project.

### Build Your Own

If you want to build OCMockito yourself, clone the repo, then

```sh
$ cd Source
$ ./MakeDistribution.sh
```

## About the Author

Jon Reid is the author of _[iOS Unit Testing by Example](https://iosunittestingbyexample.com)._  
Find more at [Quality Coding](https://qualitycoding.org).

[![Bluesky](https://img.shields.io/badge/Bluesky-0285FF?logo=bluesky&logoColor=fff)](https://bsky.app/profile/qualitycoding.org)
[![Mastodon](https://img.shields.io/mastodon/follow/109765011064804734?domain=https%3A%2F%2Fiosdev.space
)](https://iosdev.space/@qcoding)
[![YouTube](https://img.shields.io/youtube/channel/subscribers/UC69XtVGLRydpG7o1nkdQs8Q)](https://www.youtube.com/@QualityCoding)
