//
//  KIF+Utils.swift
//  SwiftmazingFunctionalTests
//
//  Created by Hélio Mesquita on 08/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import KIF
import XCTest

extension XCTestCase {

  func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
  }

}

extension KIFTestActor {

  func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
  }

  func navigateToFeed() {
    tester().tapView(withAccessibilityLabel: "Swiftmazing")
  }

}
