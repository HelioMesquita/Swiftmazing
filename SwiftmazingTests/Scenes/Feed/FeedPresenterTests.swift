//
//  FeedPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Quick

@testable import PromiseKit
@testable import SwiftmazingMock

class FeedPresenterTests: QuickSpec {

  override class func spec() {
    super.spec()

    var sut: FeedPresenter!
    var viewController: ViewControllerSpy!

    class ViewControllerSpy: FeedDisplayLogic {
      var showCalled: Bool = false
      var showListCalled: Bool = false
      var showDetailCalled: Bool = false
      var showTryAgainCalled: Bool = false

      func show(_ viewModel: Feed.ViewModel) {
        showCalled = true
      }

      func showList() {
        showListCalled = true
      }

      func showDetail() {
        showDetailCalled = true
      }

      func showTryAgain(title: String, message: String) {
        showTryAgainCalled = true
      }

      func reload() {}

    }

    beforeEach {
      viewController = ViewControllerSpy()
      sut = FeedPresenter()
      sut.viewController = viewController
    }

    describe("#mapResponse") {
      beforeEach {
        sut.mapResponse(Repositories(), Repositories())
      }

      context("when has received the request") {
        it("calls show method") {
          expect(viewController.showCalled).to(beTrue())
        }
      }
    }

    describe("#presentTryAgain") {
      beforeEach {
        sut.presentTryAgain(message: "")
      }

      context("when failure the request") {
        it("calls try again") {
          expect(viewController.showTryAgainCalled).to(beTrue())
        }
      }
    }

    describe("#presentList") {
      beforeEach {
        sut.presentList()
      }

      it("calls show list") {
        expect(viewController.showListCalled).to(beTrue())
      }
    }

    describe("#presentDetail") {
      beforeEach {
        sut.presentDetail()
      }

      it("calls show list") {
        expect(viewController.showDetailCalled).to(beTrue())
      }
    }
  }

}
