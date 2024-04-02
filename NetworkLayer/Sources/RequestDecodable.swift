//
//  RequestDecodable.swift
//  Infrastructure
//
//  Created by Helio Loredo Mesquita on 07/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

public protocol RequestDecodable: Decodable {
  init()
}
