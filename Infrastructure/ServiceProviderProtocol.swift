//
//  ServiceProviderProtocol.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import OSLog

public protocol ServiceProviderProtocol {
  var urlSession: URLSession { get }
  var jsonDecoder: JSONDecoder { get }
  func execute<T: RequestDecodable>(request: RequestProviderProtocol, parser: T.Type) async throws
    -> T
}

extension ServiceProviderProtocol {

  public var jsonDecoder: JSONDecoder {
    return JSONDecoder()
  }

  public func execute<T: RequestDecodable>(request: RequestProviderProtocol, parser: T.Type)
    async throws -> T
  {
    let (data, response) = try await urlSession.data(for: request.asURLRequest)

    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
      throw RequestError.unknownError
    }

    show(request: request.asURLRequest, response, data)

    if 200...299 ~= statusCode {
      do {
        let model = try self.jsonDecoder.decode(T.self, from: data)
        return model
      } catch {
        throw RequestError.invalidParser
      }
    } else {
      throw identify(statusCode: statusCode)
    }
  }

  fileprivate func identify(statusCode: Int) -> RequestError {
    guard let error = RequestError(rawValue: statusCode) else {
      return .unknownError
    }

    return error
  }

  private func show(request: URLRequest, _ response: URLResponse?, _ data: Data?) {
    #if DEBUG
      var requestLog = "REQUEST=================================================\n"
      requestLog += "🎯🎯🎯 URL: \(request.url?.absoluteString ?? "")\n"
      requestLog += "-----------------------------------------------------------\n"
      requestLog += "⚒⚒⚒ HTTP METHOD: \(request.httpMethod ?? "")\n"
      requestLog += "-----------------------------------------------------------\n"
      requestLog += "📝📝📝 HEADERS: \(request.allHTTPHeaderFields ?? [:])\n"
      requestLog += "-----------------------------------------------------------\n"

      requestLog += "RESPONSE================================================\n"
      requestLog += "⚠️⚠️⚠️ STATUS CODE: \((response as? HTTPURLResponse)?.statusCode ?? 0)\n"
      requestLog += "-----------------------------------------------------------\n"
      requestLog +=
        "📒📒📒 HEADERS: \((response as? HTTPURLResponse)?.allHeaderFields as? [String: String] ?? [:])\n"
      requestLog += "-----------------------------------------------------------\n"

      if let dataObj = data {
        do {
          let json = try JSONSerialization.jsonObject(with: dataObj, options: .mutableContainers)
          let prettyPrintedData = try JSONSerialization.data(
            withJSONObject: json, options: .prettyPrinted)
          requestLog +=
            "⬇️⬇️⬇️ RESPONSE DATA: \n\(String(bytes: prettyPrintedData, encoding: .utf8) ?? "")"
        } catch {
          requestLog += "⬇️⬇️⬇️ RESPONSE DATA: \n\(String(data: dataObj, encoding: .utf8) ?? "")"
        }
        requestLog += "\n===========================================================\n"
      }

      Logger(subsystem: "infrastructure", category: "infrastructure").debug("\(requestLog)")

    #endif
  }

}
