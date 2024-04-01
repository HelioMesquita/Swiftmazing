//
//  ListPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Quick

@testable import Swiftmazing

class ListPresenterTests: QuickSpec {

  override class func spec() {
    super.spec()

    var sut: ListPresenter!
    var viewController: ViewControllerSpy!

    class ViewControllerSpy: ListDisplayLogic {

      var showDetailCalled: Bool = false
      var showTitleCalled: Bool = false
      var showReloadCalled: Bool = false
      var showNextPageCalled: Bool = false
      var showTryAgainCalled: Bool = false

      func showTitle(_ title: String) {
        showTitleCalled = true
      }

      func showReload(with viewModels: [List.ListCellViewModel]) {
        showReloadCalled = true
      }
      func showNextPage(with viewModels: [List.ListCellViewModel]) {
        showNextPageCalled = true
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
      sut = ListPresenter()
      sut.viewController = viewController
    }

    describe("presentTitle") {
      beforeEach {
        sut.presentTitle("")
      }

      it("calls show title") {
        expect(viewController.showTitleCalled).to(beTrue())
      }

    }
    describe("reloadMap") {
      beforeEach {
        sut.reloadMap(RepositoriesModel(items: []).items)
      }

      it("calls to reload screen") {
        expect(viewController.showReloadCalled).to(beTrue())
      }
    }

    describe("nextPageMap") {
      beforeEach {
        sut.nextPageMap(RepositoriesModel(items: []).items)
      }

      it("calls to show next page") {
        expect(viewController.showNextPageCalled).to(beTrue())
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
  }

}
