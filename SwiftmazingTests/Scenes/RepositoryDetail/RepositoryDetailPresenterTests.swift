//
//  RepositoryDetailPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Quick

@testable import PromiseKit
@testable import Swiftmazing

class RepositoryDetailPresenterTests: QuickSpec {

  override class func spec() {
    super.spec()
    PromiseKit.conf.Q.map = nil
    PromiseKit.conf.Q.return = nil

    var sut: RepositoryDetailPresenter!
    var viewController: ViewControllerSpy!
    var repository: Repository!

    class ViewControllerSpy: RepositoryDetailDisplayLogic {

      var showImageCalled: Bool = false
      var showTitleCalled: Bool = false
      var showAuthorCalled: Bool = false
      var showDescriptionsCalled: Bool = false
      var showButtonTitleCalled: Bool = false

      func showImage(_ imageURL: URL) {
        showImageCalled = true
      }

      func showTitle(_ text: String) {
        showTitleCalled = true
      }

      func showAuthor(_ text: String) {
        showAuthorCalled = true
      }

      func showDescriptions(_ texts: [String]) {
        showDescriptionsCalled = true
      }

      func showButtonTitle(_ text: String) {
        showButtonTitleCalled = true
      }

    }

    beforeEach {
      repository = Repositories().items.first

      viewController = ViewControllerSpy()
      sut = RepositoryDetailPresenter()
      sut.viewController = viewController
    }

    describe("#presentRepository") {
      beforeEach {
        sut.presentRepository(repository)
      }

      it("shows image") {
        expect(viewController.showImageCalled).to(beTrue())
      }

      it("shows title") {
        expect(viewController.showTitleCalled).to(beTrue())
      }

      it("shows author") {
        expect(viewController.showAuthorCalled).to(beTrue())
      }

      it("shows description") {
        expect(viewController.showDescriptionsCalled).to(beTrue())
      }

      it("shows button") {
        expect(viewController.showButtonTitleCalled).to(beTrue())
      }
    }
  }

}
