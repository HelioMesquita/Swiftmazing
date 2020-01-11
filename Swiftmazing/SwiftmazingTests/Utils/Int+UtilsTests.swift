//
//  Int+UtilsTests.swift
//  SwiftmazingTests
//
//  Created by Hélio Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing

class IntUtilsTests: QuickSpec {

    override func spec() {
        super.spec()

        describe("#kiloFormat") {
            context("when the value is below than 100") {
                it("returns the same value") {
                    let value: Int = 100
                    expect(value.kiloFormat).to(equal("100"))
                }
            }
            context("when the value is 100") {
                it("returns 1k value") {
                    let value: Int = 1000
                    expect(value.kiloFormat).to(equal("1k"))
                }
            }
            context("when the value is 10000") {
                it("returns 10k value") {
                    let value: Int = 10000
                    expect(value.kiloFormat).to(equal("10k"))
                }
            }
            context("when the value is 20201") {
                it("returns 20.2k value") {
                    let value: Int = 20201
                    expect(value.kiloFormat).to(equal("20.2k"))
                }
            }
        }
    }

}


