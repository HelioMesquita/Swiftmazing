//
//  FeedNewsCellTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Visual

class FeedNewsCellTests: QuickSpec {

    override func spec() {

        var view: FeedNewsCell!

        describe("FeedNewsCell") {

            beforeEach {
                view = FeedNewsCell(frame: CGRect(x: 0, y: 0, width: 375, height: 320))
                view.titleLabel.text = "Title label"
                view.subtitleLabel.text = "Subtitle label"
                view.descriptionLabel.text = "Description Label"
                view.oddImagesStackView.addArrangedSubview(self.createImage())
                view.oddImagesStackView.addArrangedSubview(self.createImage())
                view.oddImagesStackView.addArrangedSubview(self.createImage())
                view.oddImagesStackView.addArrangedSubview(self.createImage())
                view.oddImagesStackView.addArrangedSubview(self.createImage())
                view.evenImagesStackView.addArrangedSubview(self.createImage())
                view.evenImagesStackView.addArrangedSubview(self.createImage())
                view.evenImagesStackView.addArrangedSubview(self.createImage())
                view.evenImagesStackView.addArrangedSubview(self.createImage())
                view.evenImagesStackView.addArrangedSubview(self.createImage())
            }

            it("returns the layout") {
//                expect(view) == recordSnapshot()
                expect(view) == snapshot()
            }
        }
    }

    func createImage() -> UIImageView {
         let imageView = UIImageView(image: UIImage.Design.swift)
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         return imageView
     }
}
