//
//  MockURLSession.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

class MockURLProtocol: URLProtocol {

  static var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    if let url = request.url {
      if let (error, data, response) = MockURLProtocol.mockURLs[url] {

        if let responseStrong = response {
          self.client?.urlProtocol(
            self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
        }

        if let dataStrong = data {
          self.client?.urlProtocol(self, didLoad: dataStrong)
        }

        if let errorStrong = error {
          self.client?.urlProtocol(self, didFailWithError: errorStrong)
        }
      }
    }

    self.client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}

}
