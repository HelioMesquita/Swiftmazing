//
//  Bundle+Utils.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

internal extension Bundle {

    private static let bundleID = "com.visual"

    static var module: Bundle {
        return Bundle(identifier: bundleID) ?? .main
    }

}
