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

class FeedInteractorTests: QuickSpec {

  override class func spec() {
    super.spec()
    PromiseKit.conf.Q.map = nil
    PromiseKit.conf.Q.return = nil

    var sut: FeedInteractor!
    var presenter: PresenterSpy!
    var worker: RepositoriesWorkerSpy!
    var repositories: [Repository]!
    var repository: Repository!

    class PresenterSpy: FeedPresentationLogic {

      var mapResponseCalled = false
      var presentListCalled = false
      var presentDetailCalled = false
      var presentTryAgainCalled = false

      func mapResponse(_ topRepoResponse: Repositories, _ mostRecentResponse: Repositories) {
        mapResponseCalled = true
      }

      func presentList() {
        presentListCalled = true
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
      sut = FeedInteractor(worker: worker)
      sut.presenter = presenter
    }

    describe("#loadScreen") {
      context("when successful request") {
        beforeEach {
          sut.loadScreen()
        }

        it("calls to presenter map the response") {
          expect(presenter.mapResponseCalled).to(beTrue())
        }
      }

      context("when unsuccessful request") {
        beforeEach {
          worker.isSuccess = false
          sut.loadScreen()
        }

        it("presents try again") {
          expect(presenter.presentTryAgainCalled).to(beTrue())
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

    describe("#topRepoListSelected") {
      context("when is selected a news cell or see more") {
        beforeEach {
          sut.topRepoListSelected(repositories, title: "title")
        }

        it("saves the repositories") {
          expect(sut.listRepositories.first) === repositories.first
        }

        it("saves the filter selected") {
          expect(sut.listFilter).to(equal(.stars))
        }

        it("saves the title") {
          expect(sut.listTitle).to(equal("title"))
        }

        it("calls to presenter show the list") {
          expect(presenter.presentListCalled).to(beTrue())
        }
      }
    }

    describe("#lastUpdatedListSelected") {
      context("when is selected a news cell or see more") {
        beforeEach {
          sut.lastUpdatedListSelected(repositories, title: "title")
        }

        it("saves the repositories") {
          expect(sut.listRepositories.first) === repositories.first
        }

        it("saves the filter selected") {
          expect(sut.listFilter).to(equal(.updated))
        }

        it("saves the title") {
          expect(sut.listTitle).to(equal("title"))
        }

        it("calls to presenter show the list") {
          expect(presenter.presentListCalled).to(beTrue())
        }
      }
    }

  }

}
