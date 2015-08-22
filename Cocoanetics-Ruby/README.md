Cocoanetics Ruby
================

Collection of my Ruby Scripts

###Coveralls.rb 

This script finds all **.gcda** files unterneath the current user's DerivedData folder. Since you get a fresh VM every time Travis-CI builds those should be the ones that you also want to submit.

Submission is done with [cpp_coveralls](https://github.com/eddyxu/cpp-coveralls)

The script has a few options of which -x and -e are passed onto cpp_coveralls. Typically you want to limit processing to **m** extension for Objective-C projects.

    Usage: coveralls.rb [options]
        -e, --exclude-folder FOLDER      Folder to exclude
        -h, --exclude-headers            Ignores headers
        -x, --extension EXT              Source file extension to process
        -?, --help                       Show this message

Example `**.travis.yml**`

	---
	language: objective-c

	before_script:
	  - sudo easy_install cpp-coveralls

	script:
	  - xctool -project DTFoundation.xcodeproj -scheme "Static Library" build test -sdk iphonesimulator

	after_success:
          - ./coveralls.rb --extension m --exclude-folder Demo --exclude-folder Test --exclude-folder Externals
	  
