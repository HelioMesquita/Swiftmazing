//
//  RepositoryDetailInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing
@testable import PromiseKit

class RepositoryDetailInteractorTests: QuickSpec {

    var sut: RepositoryDetailInteractor!
    var presenter: PresenterSpy!
    var repository: Repository!

    class PresenterSpy: RepositoryDetailPresentationLogic {

        var presentRepositoryCalled = false

        func presentRepository(_ repository: Repository) {
            presentRepositoryCalled = true
        }

    }

    override func spec() {
        super.spec()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil

        beforeEach {
            self.repository = Repositories().items.first

            self.presenter = PresenterSpy()
            self.sut = RepositoryDetailInteractor()
            self.sut.presenter = self.presenter
        }

        describe("#loadScreen") {
            context("when repository is not nil") {
                beforeEach {
                    self.sut.repository = self.repository
                    self.sut.loadScreen()
                }

                it("calls to presenter map the response") {
                    expect(self.presenter.presentRepositoryCalled).to(beTrue())
                }
            }

            context("when repository is nil") {
                beforeEach {
                    self.sut.loadScreen()
                }

                it("presents try again") {
                    expect(self.presenter.presentRepositoryCalled).to(beFalse())
                }
            }
        }
    }

}
