//
//  InfrastructureTests.swift
//  InfrastructureTests
//
//  Created by Hélio Mesquita on 08/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import XCTest
@testable import Infrastructure

class InfrastructureTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
//class APITests: QuickSpec {
//
//  typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void
//
//  struct BodyParser: Decodable {
//    let body: String
//  }
//
//  class MockURLSession: URLSession {
//    private let url: URL
//    private let data: Data
//    private let statusCode: Int
//
//    init(data: Data, statusCode: Int, url: URL) {
//      self.data = data
//      self.url = url
//      self.statusCode = statusCode
//    }
//
//    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//      return MockURLSessionDataTask(url: url, data: data, statusCode: statusCode, completion: completionHandler)
//    }
//  }
//
//  class MockURLSessionDataTask: URLSessionDataTask {
//    private let url: URL
//    private let data: Data
//    private let statusCode: Int
//    private let completion: DataCompletion
//    private let realSession = URLSession.shared
//
//    init(url: URL, data: Data, statusCode: Int, completion: @escaping DataCompletion) {
//      self.data = data
//      self.url = url
//      self.completion = completion
//      self.statusCode = statusCode
//    }
//
//    override func resume() {
//      let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
//      completion(data, response, nil)
//    }
//  }
//
//  override func spec() {
//    super.spec()
//
//    let bodyResponse: [String: Any] = ["body": "body123"]
//    let response = """
//    {
//      "body": "body123"
//    }
//    """.data(using: .utf8)!
//    let url = URL(string: "https://www.google.com.br")!
//    let request = Endpoint(url: "https://www.google.com.br", body: bodyResponse, authToken: "auth_token123", verb: "GET", version: "6").request()
//    var session: MockURLSession!
//
//    describe("#execute") {
//      context("when successful request") {
//
//        beforeEach {
//          session = MockURLSession(data: response, statusCode: 200, url: url)
//        }
//
//        it("returns body response as data") {
//          API(session: session).execute(request: request.value, onSuccess: { (statusCode, gnjson) in
//            let subject = try! JSONDecoder().decode(BodyParser.self, from: gnjson.data!)
//            expect(subject.body).to(equal("body123"))
//          }, onError: { (statusCode, data, error) in
//            XCTFail()
//          })
//        }
//
//        it("returns gnsjon with body") {
//          API(session: session).execute(request: request.value, onSuccess: { (statusCode, gnjson) in
//            let body = gnjson.object["body"].stringValue
//            expect(body).to(equal("body123"))
//          }, onError: { (statusCode, data, error) in
//            XCTFail()
//          })
//        }
//
//        it("returns status code 200") {
//          API(session: session).execute(request: request.value, onSuccess: { (statusCode, gnjson) in
//            expect(statusCode).to(equal(200))
//          }, onError: { (statusCode, data, error) in
//            XCTFail()
//          })
//        }
//      }
//
//      context("when unsuccessful request") {
//
//        beforeEach {
//          session = MockURLSession(data: response, statusCode: 500, url: url)
//        }
//
//        it("returns body response as data") {
//          API(session: session).execute(request: request.value, onSuccess: { (statusCode, gnjson) in
//            XCTFail()
//          }, onError: { (statusCode, data, error) in
//            let subject = try? JSONDecoder().decode(BodyParser.self, from: data!)
//            expect(subject?.body).to(equal("body123"))
//          })
//        }
//
//        it("returns status code 500") {
//          API(session: session).execute(request: request.value, onSuccess: { (statusCode, gnjson) in
//            XCTFail()
//          }, onError: { (statusCode, data, error) in
//            expect(statusCode).to(equal(500))
//          })
//        }
//      }
//    }
//  }
//}
