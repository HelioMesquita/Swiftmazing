//
//  ServiceProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import NetworkLayer

class ServiceProvider: ServiceProviderProtocol {

  var urlSession: URLSession {
    return URLSession.shared
  }

  var jsonDecoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }

  func execute<T: RequestDecodable>(request: RequestProviderProtocol, parser: T.Type) -> T {
    return T.init()
  }

}
