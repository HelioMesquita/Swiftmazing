//
//  Logger.swift
//  Infrastructure
//
//  Created by Helio Loredo Mesquita on 23/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

internal class Logger {

  static func show(request: URLRequest, _ response: URLResponse?, _ data: Data?, _ error: Error?) {
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

      if let error = error {
        requestLog += "⬇️⬇️⬇️ RESPONSE ERROR: \n\(error)"
        requestLog += "\n===========================================================\n"
      }

      print(requestLog)
    #endif
  }

}
