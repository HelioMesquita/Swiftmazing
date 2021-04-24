//
//  MockURLSession.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    private let url: URL
    private let data: Data
    private let statusCode: Int

    init(data: Data, statusCode: Int, url: URL = URL(string: "https://www.google.com.br")!) {
        self.data = data
        self.url = url
        self.statusCode = statusCode
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(url: url, data: data, statusCode: statusCode, completion: completionHandler)
    }
}
