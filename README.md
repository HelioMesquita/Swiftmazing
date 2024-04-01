<h3 align="center">
  <a href="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/swiftmazing.png">
  <img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/swiftmazing.png?raw=true" alt="Swiftmazing Logo" width="500">
  </a>
</h3>

[![Swift 5.10](https://img.shields.io/badge/Swift-5.10-blue.svg?style=flat)](https://swift.org)
[![Xcode 15.3.0](https://img.shields.io/badge/Xcode-15.3.0-blue.svg?style=flat)](https://developer.apple.com/xcode/)
[![Cocoapods](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg?style=flat)](https://cocoapods.org)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/HelioMesquita/Swiftmazing/blob/master/LICENSE)

A iOS application with layout based on App Store that can check the most starred and last updated Swift repository. It was developed in a modular way, with their respective tests using Quick, Nimble, Snapshots and/or KIF, the using the modern collection view and integrated with fastlane and slather generating test coverage


## Features

<img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/appscreenlight.png" align="right"
     title="App preview light mode" width="220  " height="476">

<img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/appscreendark.png" align="right"
     title="App preview dark mode" width="220 " height="476">

* Modularization
* Xcodegen
* CLEAN Swift Architecture (VIP)
* Modern Collection View
* Mock Mode
* Pull-to-Refresh
* Infinity Scroll using PrefetchItems
* View Code (UIKit)
* Preview using UIViewRepresentable
* Dark Mode
* Internationalization (English and PT-Br)
* Unit tests
* Snapshots Tests
* Functional Tests
<!-- * Travis CI integration
* Codecov integration
* Fastlane integration
* Slather integration -->

### Prerequisites

* [Xcode](https://developer.apple.com/xcode/) 15.3.0
* [xcodegen](https://github.com/yonaskolb/XcodeGen) 2.39.1
* [Cocoapods](https://cocoapods.org) 1.15.2
* [Bundler](https://bundler.io) 2.0.2 - Only for execute Fastlane

### Installing

First of all download and install Xcode, Cocoapods and xcodegen, then clone the repository

```
https://github.com/HelioMesquita/Swiftmazing.git
```

Go to cloned directory and execute

```
xcodegen generate
```

Open the directory project and double tap on Swiftmazing.xcworkspace

## Running the tests

For each scheme in project run some tests targets
* The Visual scheme runs the snapshots tests for all views and view controllers
* The Infrastructure scheme runs the unit tests for all network tests
* The Swiftmazing scheme runs the unit tests using Quick and Nimble for all bussiness and presentation rules
* The SwiftmazingMock scheme runs the functional tests using KIF in a mocked application

<!-- The all tests can be run also using Fastlane just execute

```
bundle install
bundle exec fastlane tests
```

When running the tests using this command automaticaly runs [Slather](https://github.com/SlatherOrg/slather) that generates a test relatory of code coverage in xml. The relatory can be found at 

```
fastlane/slather
```

If you want to see relatory in html, modify the ```.slather.yml``` changing key ```coverage_service``` to ```html```
 -->

## Built With

* [Quick](https://github.com/Quick/Quick) - The Swift (and Objective-C) testing framework.
* [Nimble](https://github.com/Quick/Nimble) - A Matcher Framework for Swift and Objective-C
* [Nimble-Snapshots](Nimble-Snapshots) - Nimble matchers for FBSnapshotTestCase
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category
* [KIF](https://github.com/kif-framework/KIF) - Keep It Functional - An iOS Functional Testing Framework
