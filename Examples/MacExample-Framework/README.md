To set up this example, open Example.xcodeproj:

1. Drag OCMockito.framework and OCHamcrest.framework into the project, specifying:
  * "Copy items into destination group's folder"
  * Add to targets: ExampleTests
  
2. Open the Build Phases for the ExampleTests target:
  * Drag OCHamcrest.framework and OCMockito.framework into the Copy Files phase
  * Destination: Products Directory

Then command-U to run unit tests. Try changing one of the tests to fail.
