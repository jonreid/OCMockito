![mockito](http://docs.mockito.googlecode.com/hg/latest/org/mockito/logo.jpg)

OCMockito is an iOS and Mac OS X implementation of Mockito, supporting creation,
verification and stubbing of mock objects.

Key differences from other mocking frameworks:

* Mock objects are always "nice," recording their calls instead of throwing
  exceptions about unspecified invocations. This makes tests less fragile.

* No expect-run-verify, making tests more readable. Mock objects record their
  calls, then you verify the methods you want.

* Verification failures are reported as unit test failures, identifying specific
  lines instead of throwing exceptions. This makes it easier to identify
  failures.


How do I add OCMockito to my project?
-------------------------------------

The Examples folder shows projects using OCMockito either through CocoaPods or
through the prebuilt frameworks, for iOS and Mac OS X development.

### CocoaPods

If you want to add OCMockito using Cocoapods then add the following dependency
to your Podfile. Most people will want OCMockito in their test targets, and not
include any pods from their main targets:

```ruby
target :MyTests, :exclusive => true do
    pod 'OCMockito', '~> 1.0'
end
```

Use the following imports:

    #define HC_SHORTHAND
    #import <OCHamcrest/OCHamcrest.h>

    #define MOCKITO_SHORTHAND
    #import <OCMockito/OCMockito.h>

### Prebuilt Frameworks

Prebuilt binaries are available on GitHub for
[OCMockito](https://github.com/jonreid/OCMockito/releases/). You will also need
[OCHamcrest](https://github.com/hamcrest/OCHamcrest/releases/).
The binaries are packaged as frameworks:

* __OCMockitoIOS.framework__ for iOS development
* __OCMockito.framework__ for Mac OS X development

OCHamcrest comes in a similar scheme. Drag the appropriate frameworks for both
both OCMockito and OCHamcrest into your project, specifying "Copy items into
destination group's folder".

#### iOS Development:

Use the following imports:

    #define HC_SHORTHAND
    #import <OCHamcrestIOS/OCHamcrestIOS.h>
    
    #define MOCKITO_SHORTHAND
    #import <OCMockitoIOS/OCMockitoIOS.h>

__Project Setup using CocoaPods:__

If you want to add OCMockito using Cocoapods then add the following dependency to your Podfile where <version> is the version you would like to use. 

	pod 'OCMockito', '~> <version>'

Add:

    #define HC_SHORTHAND
    #import OCHamcrest.h

    #define MOCKITO_SHORTHAND
    #import OCMockito.h


#### Mac OS X Development:

Add a "Copy Files" build phase to copy OCHamcrest.framework to your Products
Directory.

Use the following imports:

    #define HC_SHORTHAND
    #import <OCHamcrest/OCHamcrest.h>
    
    #define MOCKITO_SHORTHAND
    #import <OCMockito/OCMockito.h>


### Build Your Own

If you want to build OCMockito yourself, clone the repo, copy OCHamcrest-3.0.0
into the Frameworks folder, then

```sh
$ git submodule update --init
$ cd Source
$ ./MakeDistribution.sh
```

### Xcode 5 confused by verify:

Xcode 5 currently seems to get confused about #defines, and may complain
"Ambiguous expansion of macro 'verify'". If this happens, change your Build
Settings to set "Enable Modules" to No.
 

Let's verify some behavior!
---------------------------

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


How about some stubbing?
------------------------

```obj-c
// mock creation
NSArray *mockArray = mock([NSArray class]);

// stubbing
[given([mockArray objectAtIndex:0]) willReturn:@"first"];

// following prints "(null)" because objectAtIndex:999 was not stubbed
NSLog(@"%@", [mockArray objectAtIndex:999]);
```


How do you mock a class object?
-------------------------------

```obj-c
Class mockStringClass = mockClass([NSString class]);
```


How do you mock a protocol?
---------------------------

```obj-c
id <MyDelegate> delegate = mockProtocol(@protocol(MyDelegate));
```


How do you mock an object that also implements a protocol?
----------------------------------------------------------

```obj-c
UIViewController <CustomProtocol> *controller =
    mockObjectAndProtocol([UIViewController class], @protocol(CustomProtocol));
```


How do you stub methods that return non-objects?
------------------------------------------------

To stub methods that return non-object types, specify `willReturn<type>`,
like this:

```obj-c
[given([mockArray count]) willReturnUnsignedInteger:3];
```


Argument matchers
-----------------

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


How do you specify matchers for primitive arguments?
----------------------------------------------------

To stub a method that takes a primitive argument but specify a matcher, invoke
the method with a dummy argument, then call `-withMatcher:forArgument:`

```obj-c
[[given([mockArray objectAtIndex:0]) withMatcher:anything() forArgument:0]
 willReturn:@"foo"];
```

Use the shortcut `-withMatcher:` to specify a matcher for a single argument:

```obj-c
[[given([mockArray objectAtIndex:0]) withMatcher:anything()]
 willReturn:@"foo"];
```


Verifying exact number of invocations / at least x / never
----------------------------------------------------------

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

// verify using atLeast
[verifyCount(mockArray, atLeastOnce()) addObject:@"at least once"];
[verifyCount(mockArray, atLeast(2)) addObject:@"at least twice"];
```


Capturing arguments for further assertions
------------------------------------------

OCMockito verifies argument values by using any provided OCHamcrest matchers,
with the default matcher being `equalTo` to test for equality. This is the
recommended way of matching arguments because it makes tests clean and simple.
In some situations though, it's helpful to assert on certain arguments after the
actual verification. For example:

```obj-c
MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];
[verify(mockObject) doSomething:[argument capture]];
assertThat([[argument value] nameAtIndex:0], is(@"Jon"));
```

Capturing arguments is especially handy for block arguments. You can capture a
block, then invoke it within your test:

```obj-c
MKTArgumentCaptor *argument = [[MKTArgumentCaptor alloc] init];
[verify(mockArray) sortUsingComparator:[argument capture]];
NSComparator block = [argument value];
assertThatInt(block(@"a", @"z"), equalToInt(NSOrderedAscending));
```


More resources
--------------

* [Sources](https://github.com/jonreid/OCMockito)
* [OCHamcrest](https://github.com/hamcrest/OCHamcrest)
* [Quality Coding](http://qualitycoding.org/) - Tools, tips &
techniques for _building quality in_ to iOS development.
