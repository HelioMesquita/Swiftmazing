//
//  RequestError.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

public enum RequestError: Int, Error, LocalizedError, Equatable {

    public typealias RawValue = Int

    case unknownError = 0
    case invalidParser = 1
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404

    public var localizedDescription: String {
        return Text(rawValue: String(describing: self))?.value ?? ""
    }

}
