//
//  RequestProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import NetworkLayer

extension RequestProviderProtocol {

  var scheme: String {
    return Bundle.main.scheme
  }

  var host: String {
    return Bundle.main.host
  }

  var bodyParameters: Encodable? {
    return nil
  }

  var queryParameters: [URLQueryItem]? {
    return nil
  }

  var headers: [String: String] {
    return ["Content-Type": "application/json"]
  }

}
