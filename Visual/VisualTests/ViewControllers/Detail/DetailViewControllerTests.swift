//
//  FeedCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Visual

class DetailViewControllerTests: QuickSpec {

    override func spec() {

        var view: DetailViewController!

        describe("FeedCollectionViewController") {

            beforeEach {
                view = DetailViewController()
                view.titleLabel.text = "Title"
                view.authorLabel.text = "Author"
                view.setDescriptions(["Descriptions", "Descriptions"])
            }

            it("returns the layout") {
//                expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
                expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
            }
        }
    }
}
