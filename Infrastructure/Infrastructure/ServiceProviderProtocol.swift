//
//  ServiceProviderProtocol.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import PromiseKit

public protocol ServiceProviderProtocol {
    var urlSession: URLSession { get }
    var jsonDecoder: JSONDecoder { get }
    func execute<T: Decodable>(request: RequestProviderProtocol, parser: T.Type) -> Promise<T>
}

extension ServiceProviderProtocol {

    public var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }

    public func execute<T: Decodable>(request: RequestProviderProtocol, parser: T.Type) -> Promise<T> {
        return Promise<T> { seal in
            urlSession.dataTask(with: request.asURLRequest) { (data, response, error) in
                Logger.show(request: request.asURLRequest, response, data, error)

                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, let data = data else {
                    seal.reject(RequestError.unknownError)
                    return
                }

                if 200...299 ~= statusCode {
                    do {
                        let model = try self.jsonDecoder.decode(T.self, from: data)
                        seal.fulfill(model)
                    } catch {
                        seal.reject(RequestError.invalidParser)
                    }

                } else {
                    seal.reject(self.identify(statusCode: statusCode))
                }
            }.resume()
        }
    }

    fileprivate func identify(statusCode: Int) -> RequestError {
        guard let error = RequestError(rawValue: statusCode) else {
            return .unknownError
        }

        return error
    }

}
