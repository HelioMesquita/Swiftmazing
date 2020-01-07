//
//  BundleTests.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Visual

class BundleTests: QuickSpec {

    override func spec() {
        super.spec()

        describe("#module") {
            it("returns module name") {
                expect(Bundle.module.bundleIdentifier).to(equal("com.callidus.Visual"))
            }
        }
    }

}
