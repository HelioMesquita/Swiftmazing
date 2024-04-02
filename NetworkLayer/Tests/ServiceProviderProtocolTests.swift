//
//  InfrastructureTests.swift
//  InfrastructureTests
//
//  Created by Hélio Mesquita on 08/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import NetworkLayer

class ServiceProviderProtocolTests: XCTestCase {

  let jsonData = """
        {
          "body": "body123"
        }
    """.data(using: .utf8)!

  struct ValidParser: RequestDecodable {
    let body: String

    init() {
      body = ""
    }
  }

  struct InvalidParser: RequestDecodable {
    let corpo: String

    init() {
      corpo = ""
    }
  }

  struct ValidBuilder: BuilderProviderProtocol {
    func build(response: ServiceProviderProtocolTests.ValidParser) throws
      -> ServiceProviderProtocolTests.ValidParser
    {
      return response
    }

  }

  struct InvalidBuilder: BuilderProviderProtocol {
    func build(response: ServiceProviderProtocolTests.InvalidParser) throws
      -> ServiceProviderProtocolTests.ValidParser
    {
      return ValidParser()
    }

  }

  var mockURLSession: URLSession!
  let request = MockProvider()

  override func tearDownWithError() throws {
    mockURLSession = nil
    try super.tearDownWithError()
  }

  func generateMockURLSession(statusCode: Int = 200) {
    let url = request.asURLRequest.url!
    let response = HTTPURLResponse(
      url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    MockURLProtocol.mockURLs = [url: (nil, jsonData, response)]

    let sessionConfiguration = URLSessionConfiguration.ephemeral
    sessionConfiguration.protocolClasses = [MockURLProtocol.self]
    mockURLSession = URLSession(configuration: sessionConfiguration)
  }

  func testWhenPerformARequestWithSuccessAndCorrectParserItReturnsMockModel() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession()
        let subject = ServiceProvider(customURLSession: mockURLSession)

        let response = try await subject.execute(request: MockProvider(), builder: ValidBuilder())
        XCTAssertEqual(response.body, "body123")
        expectation.fulfill()
      } catch {
        XCTFail()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

  func testWhenPerformARequestWithSuccessAndIncorrectParserItReturnsMockModel() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession()
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(
          request: MockProvider(), builder: InvalidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.invalidParser)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsBadRequestError() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 400)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.badRequest)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsUnauthorizedError() {

    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 401)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.unauthorized)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)

  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsForbiddenError() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 403)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.forbidden)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)

  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsNotFoundError() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 404)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.notFound)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsServerError() {

    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 500)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.serverError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

  func testWhenPerformARequestWithUnsuccessWithKnowErrorItReturnsUnknownError() {
    let expectation = XCTestExpectation()
    Task { @MainActor in
      do {
        generateMockURLSession(statusCode: 999)
        let subject = ServiceProvider(customURLSession: mockURLSession)

        _ = try await subject.execute(request: MockProvider(), builder: ValidBuilder())

        XCTFail()
      } catch {
        XCTAssertEqual(error as! RequestError, RequestError.unknownError)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 1)
  }

}

class ServiceProvider: ServiceProviderProtocol {

  var customURLSession: URLSession

  var urlSession: URLSession {
    return customURLSession
  }

  init(customURLSession: URLSession) {
    self.customURLSession = customURLSession
  }

}
