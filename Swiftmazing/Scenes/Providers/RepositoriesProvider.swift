//
//  BaseRepositoriesProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 01/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

enum Filter: String {
    case stars
    case updated
    case none = ""
}

class RepositoriesProvider: RequestProviderProtocol {

    static let itemsPerPage: Int = 10
    var httpVerb: HttpVerbs = .GET
    var path: String = "/search/repositories"
    var page: Int
    let filter: Filter

    var queryParameters: [URLQueryItem]? {
        return [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: filter.rawValue),
            URLQueryItem(name: "per_page", value: "\(RepositoriesProvider.itemsPerPage)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }

    init(filter: Filter, page: Int) {
        self.filter = filter
        self.page = page
    }

}
