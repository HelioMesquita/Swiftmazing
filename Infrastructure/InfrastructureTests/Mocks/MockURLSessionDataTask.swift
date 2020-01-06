//
//  MockURLSessionDataTask.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let url: URL
    private let data: Data
    private let statusCode: Int
    private let completion: DataCompletion

    init(url: URL, data: Data, statusCode: Int, completion: @escaping DataCompletion) {
        self.data = data
        self.url = url
        self.completion = completion
        self.statusCode = statusCode
    }

    override func resume() {
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        completion(data, response, nil)
    }
}
