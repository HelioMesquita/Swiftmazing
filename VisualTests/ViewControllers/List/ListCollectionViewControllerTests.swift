//
//  ListCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Visual

class MockListCollectionViewModelProtocol: ListCollectionViewModelProtocol {
    var title: String = "Title"
    var description: String = "Description"
    var additionalInfo: String = "27.3k"
    var supplementaryInfo: String = "stars"
    var image: URL?
}

class ListCollectionViewControllerTests: QuickSpec {

    override func spec() {

        var view: ListCollectionViewController<MockListCollectionViewModelProtocol>!

        describe("ListCollectionViewController") {

            beforeEach {
                view = ListCollectionViewController<MockListCollectionViewModelProtocol>()
                view.viewDidLoad()
                var snapshot = NSDiffableDataSourceSnapshot<ListSection, MockListCollectionViewModelProtocol>()
                snapshot.appendSections([.repo])
                snapshot.appendItems([MockListCollectionViewModelProtocol(), MockListCollectionViewModelProtocol(), MockListCollectionViewModelProtocol()], toSection: .repo)
                view.dataSource.apply(snapshot, animatingDifferences: false)
            }

            it("returns the layout") {
//                expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
                expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
            }
        }
    }
}
