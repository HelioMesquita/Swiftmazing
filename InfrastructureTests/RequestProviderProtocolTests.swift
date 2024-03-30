//
//  RequestProviderProtocolTests.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Infrastructure

class RequestProviderProtocolTests: QuickSpec {

    override class func spec() {
        super.spec()
        
        let subject: RequestProviderProtocol = MockProvider()

        describe("#asURLRequest") {
            it("returns full url") {
                expect(subject.asURLRequest.url?.absoluteString).to(equal("https://api.github.com/repositories?key=value"))
            }

            it("returns header") {
                expect(subject.asURLRequest.allHTTPHeaderFields).to(equal(["Content-Type": "application/json"]))
            }

            it("returns body") {
                expect(subject.asURLRequest.httpBody).toNot(beNil())
            }
        }

    }

}
