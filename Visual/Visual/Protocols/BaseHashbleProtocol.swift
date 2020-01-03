//
//  BaseHashbleProtocol.swift
//  Visual
//
//  Created by Hélio Mesquita on 02/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

public protocol BaseHashbleProtocol: Hashable {
    var id: String { get }

    func hash(into hasher: inout Hasher)
}

public extension BaseHashbleProtocol {

    var id: String {
        return UUID().uuidString
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

}
