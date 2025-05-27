<h3 align="center">
  <a href="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/swiftmazing.png">
  <img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/swiftmazing.png?raw=true" alt="Swiftmazing Logo" width="500">
  </a>
</h3>

[![Swift 6](https://img.shields.io/badge/Swift-6-blue.svg?style=flat)](https://swift.org)
[![Xcode 16.2.0](https://img.shields.io/badge/Xcode-16.2.0-blue.svg?style=flat)](https://developer.apple.com/xcode/)
[![SPM](https://img.shields.io/badge/spm-compatible-blue.svg?style=flat)](https://www.apple.com)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/HelioMesquita/Swiftmazing/blob/master/LICENSE)
[![codecov](https://codecov.io/github/HelioMesquita/Swiftmazing/graph/badge.svg?token=VXr26Snj88)](https://codecov.io/github/HelioMesquita/Swiftmazing)

A iOS application with layout based on App Store that can check the most starred and last updated Swift repository. It was developed in a modular way using SPM, with their respective tests and using the modern collection view


## Features

<img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/appscreenlight.png" align="right"
     title="App preview light mode" width="220  " height="476">

<img src="https://github.com/HelioMesquita/Swiftmazing/blob/master/.assets/appscreendark.png" align="right"
     title="App preview dark mode" width="220 " height="476">

* Modularization using SPM
* Xcodegen
* MVVM with Combine
* Modern Collection View
* Pull-to-Refresh
* Infinity Scroll using PrefetchItems
* View Code (UIKit)
* Preview using UIViewRepresentable
* Dark Mode
* Internationalization (English and PT-Br)
* Unit tests
* Snapshots Tests
* Await/Async Request
* Swift 6 - Strict Concurrency

### Prerequisites

* [Xcode](https://developer.apple.com/xcode/) 16.2.0
* [Xcodegen](https://github.com/yonaskolb/XcodeGen) 2.39.1

### Installing

First of all download and install Xcode, and Xcodegen, then clone the repository

```
https://github.com/HelioMesquita/Swiftmazing.git
```

Go to cloned directory and execute

```
xcodegen generate
```

Open the directory project and double tap on Swiftmazing.xcodeproj

## Running the tests

For each scheme in project run some tests targets
* The Swiftmazing scheme runs the unit tests for all business and presentation rules
* The UIComponents scheme runs the snapshot tests for all views and view controllers
* The NetworkLayer scheme runs the unit tests for all network tests


## Built With

* [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) - PointFree Snapshot Testing
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category
