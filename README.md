# Swiftmazing

[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-blue.svg?style=flat)](https://swift.org)
[![Xcode 11.3](https://img.shields.io/badge/Xcode-11.3-blue.svg?style=flat)](https://developer.apple.com/xcode/)
[![Cocoapods](https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg?style=flat)](https://cocoapods.org)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/HelioMesquita/Swiftmazing/blob/master/LICENSE)
[![codecov](https://codecov.io/gh/HelioMesquita/Swiftmazing/branch/master/graph/badge.svg)](https://codecov.io/gh/HelioMesquita/Swiftmazing)
[![Build Status](https://travis-ci.org/HelioMesquita/Swiftmazing.svg?branch=master)](https://travis-ci.org/HelioMesquita/Swiftmazing)

A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.
It were developed in a modular way, with their respective tests using Quick, Nimble, Snapshots and/or KIF, the using the modern collection view and integrated with fastlane and slather generating test coverage.


## Features

* Modularization
* CLEAN Swift Architecture (VIP)
* Modern Collection View
* Mock Mode
* Pull-to-Refresh
* Infinity Scroll using PrefetchItems
* View Code (UIKit)
* Preview for View Code using UIViewRepresentable
* Dark Mode
* Internationalization (English and Portuguese-Brazil)
* Unit tests
* Snapshots Tests
* Functional Tests
* Travis CI integration
* Codecov integration
* Fastlane integration
* Slather integration

### Prerequisites

* [Xcode](https://developer.apple.com/xcode/) 11.3
* [Cocoapods](https://cocoapods.org) 1.8.5
* [Bundler](https://bundler.io) 2.0.2 - Only for execute Fastlane

### Installing

First of all download and install Xcode and Cocoapods, then clone the repository

```
https://github.com/HelioMesquita/Swiftmazing.git
```

Go to cloned directory and execute

```
pod install
```

Open the directory project and touble tap on Swiftmazing.xcworkspace

## Running the tests

For each scheme in project run some tests targets
* The visual scheme runs the snapshots tests for all views and view controllers
* The Infrastructure scheme runs the unit tests using Quick and Nimble for all network tests
* The Swiftmazing scheme runs the unit tests using Quick and Nimble for all bussiness and presentation rules
* The SwiftmazingMock scheme runs the functional tests using KIF in a mocked application
* The SwiftmazingTests scheme runs all tests 

The all tests can be run also using Fastlane just execute

```
bundle install
bundle exec fastlane tests
```

When running the tests using this command automaticaly runs [Slather](https://github.com/SlatherOrg/slather) that generates a test relatory of code coverage

## Built With

* [Quick](https://github.com/Quick/Quick) - The Swift (and Objective-C) testing framework.
* [Nimble](https://github.com/Quick/Nimble) -   A Matcher Framework for Swift and Objective-C
* [Nimble-Snapshots](Nimble-Snapshots) - Nimble matchers for FBSnapshotTestCase
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category
* [PromiseKit](https://github.com/mxcl/PromiseKit) - Promises for Swift & ObjC.
* [KIF](https://github.com/kif-framework/KIF) - Keep It Functional - An iOS Functional Testing Framework
