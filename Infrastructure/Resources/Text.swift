//
//  Text.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 03/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

internal enum Text: String {

  case unknownError
  case invalidParser
  case badRequest
  case unauthorized
  case notFound

  public var value: String {
    return String(describing: self.rawValue).localized()
  }

}
