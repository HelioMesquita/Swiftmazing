//
//  Text.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 03/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

enum Text: String {
    case bestRepositories
    case renownedRepositories
    case bestTools
    case updatedRepositories
    case latestUpdates
    case mostUpdatedRepositories

    public var value: String {
        return String(describing: self).localized()
    }

}
