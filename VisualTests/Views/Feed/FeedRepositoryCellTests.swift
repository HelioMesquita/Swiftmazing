//
//  FeedRepositoryCellTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Visual

class FeedRepositoryCellTests: QuickSpec {

    override func spec() {

        var view: FeedRepositoryCell!

        describe("FeedRepositoryCell") {

            beforeEach {
                view = FeedRepositoryCell(frame: CGRect(x: 0, y: 0, width: 375, height: 79))
                view.titleLabel.text = "Name label"
                view.descriptionLabel.text = "Description Label"
                view.imageView.image = UIImage.Design.swift
                view.additionalInfoLabel.text = "27.1k"
                view.supplementaryInfoLabel.text = "stars"
            }

            it("returns the layout") {
//                expect(view) == recordSnapshot()
                expect(view) == snapshot()
            }
        }
    }
}
