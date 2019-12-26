//
//  MostRecentRepositoriesProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

class PreviewLastUpdatedRepositoriesProvider: RequestProviderProtocol {

    var httpVerb: HttpVerbs = .GET
    var path: String = "/search/repositories"

    var queryParameters: [URLQueryItem]? {
        return [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "updated"),
            URLQueryItem(name: "per_page", value: "10"),
        ]
    }

}
