//
//  ListRepositoryCellTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick

@testable import Visual

class ListRepositoryCellTests: QuickSpec {

  override class func spec() {

    describe("ListRepositoryCell") {

      var view: ListRepositoryCell!

      beforeEach {
        view = ListRepositoryCell(frame: CGRect(x: 0, y: 0, width: 375, height: 118))
        view.titleLabel.text = "Name label"
        view.descriptionLabel.text = "Description Label"
        view.imageView.image = UIImage.Design.swift
        view.additionalInfoLabel.text = "27.31k"
        view.supplementaryInfoLabel.text = "stars"
      }

      it("returns the layout") {
        //                expect(view) == recordSnapshot()
        expect(view) == snapshot()
      }
    }
  }
}
