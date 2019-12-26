//
//  Logger.swift
//  Infrastructure
//
//  Created by Helio Loredo Mesquita on 23/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

//open class Logger {
//
//    static let shared = Logger()
//
//    public init() {}
//
//    /**
//     Print a bug with detailed information.
//
//     - Parameters:
//     - message: The message. Empty by default.
//     - file: The file name. Retrieves the file name by default.
//     - function: The function name. Retrieves the function name by default.
//     - line: The line number. Retrieves the line number by default.
//     */
//    open func logFailedPrecondition(_ message: String = "", file: String = #file, function: String = #function, line: Int = #line) {
//        #if DEBUG
//        print("PANNetworking caught a BUG: \n \tClass: \((file.components(separatedBy: "/").last ?? ""))\n \tFunc: \(function)\n \tLine: \(line)\n \t Log: \(message) ")
//        #endif
//    }
//
//    static func logRequest(request: URLRequest) {
//        var requestDebugLog = "==REQUEST===============================================\n"
//        requestDebugLog += "🎯🎯🎯 URL: \(request.url?.absoluteString ?? "")\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "⚒⚒⚒ HTTP METHOD: \(request.httpMethod ?? "")\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "📝📝📝 HEADERS: \(request.allHTTPHeaderFields ?? [:])\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "✅✅✅ CURL: \(request.curlString)\n"
//        requestDebugLog += "===========================================================\n"
//        print(requestDebugLog)
//    }
//
//    static func logRequestCA(request: MASRequest) {
//        var requestDebugLog = "==REQUEST===============================================\n"
//        requestDebugLog += "🎯🎯🎯 URL: \(request.endPoint ?? "")\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "⚒⚒⚒ HTTP METHOD: \(request.httpMethod )\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "📝📝📝 HEADERS: \(parseDict(dict: request.header as! Dictionary<String, Any>))\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        requestDebugLog += "📝📝📝 BODY: \(parseDict(dict: request.body as! Dictionary<String, Any>))\n"
//        requestDebugLog += "-----------------------------------------------------------\n"
//        print(requestDebugLog)
//    }
//
//    static func logResponse(_ response: URLResponse?,_ data: Data?) {
//        var responseDebugLog = "==RESPONSE==============================================\n"
//        responseDebugLog += "⚠️⚠️⚠️ STATUS CODE: \((response as? HTTPURLResponse)?.statusCode ?? -1)\n"
//        responseDebugLog += "-----------------------------------------------------------\n"
//        responseDebugLog += "📒📒📒 HEADERS: \((response as? HTTPURLResponse)?.allHeaderFields as? [String: String] ?? [:])\n"
//        responseDebugLog += "-----------------------------------------------------------\n"
//
//        if let dataObj = data {
//            do {
//                let json = try JSONSerialization.jsonObject(with: dataObj, options: .mutableContainers)
//                let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                responseDebugLog += "⬇️⬇️⬇️ RESPONSE DATA: \n\(String(bytes: prettyPrintedData, encoding: .utf8) ?? "")"
//            } catch {
//                responseDebugLog += "⬇️⬇️⬇️ RESPONSE DATA: \n\(String(data: dataObj, encoding: .utf8) ?? "")"
//            }
//            responseDebugLog += "\n"
//        }
//        responseDebugLog += "===========================================================\n"
//
//        #if DEBUG
//        print(responseDebugLog)
//        #endif
//    }
//
//    static func logResponseError(_ response: URLResponse?,_ error: Error?) {
//        var responseDebugLog = "==RESPONSE==============================================\n"
//        responseDebugLog += "⚠️⚠️⚠️ STATUS CODE: \((response as? HTTPURLResponse)?.statusCode ?? -1)\n"
//        responseDebugLog += "-----------------------------------------------------------\n"
//        responseDebugLog += "📒📒📒 HEADERS: \((response as? HTTPURLResponse)?.allHeaderFields as? [String: String] ?? [:])\n"
//        responseDebugLog += "-----------------------------------------------------------\n"
//
//        if let error = error {
//            responseDebugLog += "⬇️⬇️⬇️ RESPONSE ERROR: \n\(error)"
//            responseDebugLog += "\n"
//        }
//        responseDebugLog += "===========================================================\n"
//
//        #if DEBUG
//        print(responseDebugLog)
//        #endif
//    }
//
//    static func parseDict(dict: Dictionary<String, Any>) -> String {
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: dict)
//            if let json = String(data: jsonData, encoding: .utf8) {
//                return json
//            }
//        } catch {
//            print("something went wrong with parsing json")
//        }
//        return ""
//    }
//}
