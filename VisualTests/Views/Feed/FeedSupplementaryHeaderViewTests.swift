//
//  FeedSupplementaryFooterViewTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick

@testable import Visual

class FeedSupplementaryHeaderViewTests: QuickSpec {

  var superView: UIView!

  override class func spec() {

    describe("FeedSupplementaryHeaderView") {

      var view: FeedSupplementaryHeaderView!

      beforeEach {
        view = FeedSupplementaryHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
        view.label.text = "Name label"
        view.button.setTitle("See more", for: .normal)
      }

      it("returns the layout") {
        //                expect(view) == recordSnapshot()
        expect(view) == snapshot()
      }
    }
  }
}
