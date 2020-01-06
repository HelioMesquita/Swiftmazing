//
//  RequestError.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

public enum RequestError: Int, Error, LocalizedError {

    public typealias RawValue = Int

    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case unknownError = 0

    public var localizedDescription: String {
        return String(describing: self).localized()
    }

}
