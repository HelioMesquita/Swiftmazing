//
//  RequestProtocol.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var bodyParameters: Encodable? { get }
  var queryParameters: [URLQueryItem]? { get }
  var headers: [String: String] { get }
  var httpVerb: HttpVerbs { get }
  var asURLRequest: URLRequest { get }
}

extension RequestProtocol {

  public var asURLRequest: URLRequest {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path
    components.queryItems = queryParameters

    var request = URLRequest(url: components.url!)
    request.httpMethod = httpVerb.rawValue
    headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

    if let bodyParameters = bodyParameters, let data = bodyParameters.toJSONData() {
      request.httpBody = data
    }

    return request
  }

}

extension Encodable {

  fileprivate func toJSONData() -> Data? {
    return try? JSONEncoder().encode(self)
  }

}
