//
//  MockProvider.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

@testable import Infrastructure

class MockProvider: RequestProviderProtocol {

    struct Endoder: Encodable {
        let body: String = "body"
    }

    var path: String {
        return "/repositories"
    }

    var httpVerb: HttpVerbs {
        return .GET
    }

    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.github.com"
    }

    var bodyParameters: Encodable? {
        return Endoder()
    }

    var queryParameters: [URLQueryItem]? {
        return [URLQueryItem(name: "key", value: "value")]
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }

}
