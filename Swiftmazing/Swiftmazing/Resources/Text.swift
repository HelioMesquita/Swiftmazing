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
    case theLatestUpdates
    case mostUpdatedRepositories
    case stars
    case lastUpdate
    case forks
    case issues
    case tryAgain
    case anErrorHappened
    case seeRepository

    public var value: String {
        return String(describing: self).localized()
    }

}
