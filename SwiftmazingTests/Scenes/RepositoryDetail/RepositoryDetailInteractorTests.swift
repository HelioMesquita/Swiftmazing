//
//  RepositoryDetailInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Quick

@testable import PromiseKit
@testable import Swiftmazing

class RepositoryDetailInteractorTests: QuickSpec {

  override class func spec() {
    super.spec()
    PromiseKit.conf.Q.map = nil
    PromiseKit.conf.Q.return = nil

    var sut: RepositoryDetailInteractor!
    var presenter: PresenterSpy!
    var repository: Repository!

    class PresenterSpy: RepositoryDetailPresentationLogic {

      var presentRepositoryCalled = false

      func presentRepository(_ repository: Repository) {
        presentRepositoryCalled = true
      }

    }

    beforeEach {
      repository = Repositories().items.first

      presenter = PresenterSpy()
      sut = RepositoryDetailInteractor()
      sut.presenter = presenter
    }

    describe("#loadScreen") {
      context("when repository is not nil") {
        beforeEach {
          sut.repository = repository
          sut.loadScreen()
        }

        it("calls to presenter map the response") {
          expect(presenter.presentRepositoryCalled).to(beTrue())
        }
      }

      context("when repository is nil") {
        beforeEach {
          sut.loadScreen()
        }

        it("presents try again") {
          expect(presenter.presentRepositoryCalled).to(beFalse())
        }
      }
    }
  }

}
