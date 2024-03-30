//
//  FeedNewsCellTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick

@testable import Visual

class FeedNewsCellTests: QuickSpec {

  override class func spec() {

    func createImage() -> UIImageView {
      let imageView = UIImageView(image: UIImage.Design.swift)
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      return imageView
    }

    var view: FeedNewsCell!

    describe("FeedNewsCell") {

      beforeEach {
        view = FeedNewsCell(frame: CGRect(x: 0, y: 0, width: 375, height: 320))
        view.titleLabel.text = "Title label"
        view.subtitleLabel.text = "Subtitle label"
        view.descriptionLabel.text = "Description Label"
        view.oddImagesStackView.addArrangedSubview(createImage())
        view.oddImagesStackView.addArrangedSubview(createImage())
        view.oddImagesStackView.addArrangedSubview(createImage())
        view.oddImagesStackView.addArrangedSubview(createImage())
        view.oddImagesStackView.addArrangedSubview(createImage())
        view.evenImagesStackView.addArrangedSubview(createImage())
        view.evenImagesStackView.addArrangedSubview(createImage())
        view.evenImagesStackView.addArrangedSubview(createImage())
        view.evenImagesStackView.addArrangedSubview(createImage())
        view.evenImagesStackView.addArrangedSubview(createImage())
      }

      it("returns the layout") {
        //                expect(view) == recordSnapshot()
        expect(view) == snapshot()
      }
    }
  }

}
