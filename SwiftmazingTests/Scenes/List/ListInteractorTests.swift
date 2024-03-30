//
//  FeedInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Quick

@testable import PromiseKit
@testable import SwiftmazingMock

class ListInteractorTests: QuickSpec {

  override class func spec() {
    super.spec()
    PromiseKit.conf.Q.map = nil
    PromiseKit.conf.Q.return = nil

    var sut: ListInteractor!
    var presenter: PresenterSpy!
    var worker: RepositoriesWorkerSpy!
    var repositories: [Repository]!
    var repository: Repository!

    class PresenterSpy: ListPresentationLogic {

      var presentTitleCalled: Bool = false
      var reloadMapCalled: Bool = false
      var nextPageMapCalled: Bool = false
      var presentDetailCalled: Bool = false
      var presentTryAgainCalled: Bool = false

      func presentTitle(_ title: String) {
        presentTitleCalled = true
      }

      func reloadMap(_ repositories: [Repository]) {
        reloadMapCalled = true
      }

      func nextPageMap(_ repositories: [Repository]) {
        nextPageMapCalled = true
      }

      func presentDetail() {
        presentDetailCalled = true
      }

      func presentTryAgain(message: String) {
        presentTryAgainCalled = true
      }

    }

    beforeEach {
      repositories = Repositories().items
      repository = Repositories().items.first

      worker = RepositoriesWorkerSpy()
      presenter = PresenterSpy()
      sut = ListInteractor(worker: worker)
      sut.presenter = presenter
    }

    describe("#loadScreen") {
      context("when the screen loads") {
        beforeEach {
          sut.loadScreen()
        }

        it("calls to presenter show the title") {
          expect(presenter.presentTitleCalled).to(beTrue())
        }

        it("calls to presenter map the response") {
          expect(presenter.reloadMapCalled).to(beTrue())
        }
      }
    }

    describe("#reloadRepositories") {
      context("when is pulled to refresh") {
        context("perform the request") {
          context("successful request") {
            beforeEach {
              sut.reloadRepositories()
            }

            it("sets the current page to 1") {
              expect(sut.currentPage).to(equal(1))
            }

            it("calls to presenter map the response") {
              expect(presenter.reloadMapCalled).to(beTrue())
            }
          }

          context("unsuccessful request") {
            beforeEach {
              worker.isSuccess = false
              sut.reloadRepositories()
            }

            it("sets the current page to 1") {
              expect(sut.currentPage).to(equal(1))
            }

            it("presents try again") {
              expect(presenter.presentTryAgainCalled).to(beTrue())
            }
          }
        }

      }
    }

    describe("#repositorySelected") {
      context("when is selected a repository cell") {
        beforeEach {
          sut.repositorySelected(repository)
        }

        it("saves the selected repository") {
          expect(sut.selectedRepository) === repository

        }

        it("calls to presenter show the detail") {
          expect(presenter.presentDetailCalled).to(beTrue())
        }
      }
    }

    describe("#prefetchNextPage") {
      context("when the list is in the middle") {
        beforeEach {
          sut.prefetchNextPage(index: 5)
        }
        it("does not get to next page") {
          expect(presenter.nextPageMapCalled).to(beFalse())
        }
      }

      context("when finished the list") {
        context("perform the request") {
          context("successful request") {
            beforeEach {
              sut.prefetchNextPage(index: 9)
            }

            it("calls to presenter map the response") {
              expect(presenter.nextPageMapCalled).to(beTrue())
            }

            it("increases the current page by one") {
              expect(sut.currentPage).to(equal(2))
            }
          }

          context("unsuccessful request") {
            beforeEach {
              worker.isSuccess = false
              sut.prefetchNextPage(index: 9)
            }

            it("presents try again") {
              expect(presenter.presentTryAgainCalled).to(beTrue())
            }
          }
        }

      }
    }

  }

}
