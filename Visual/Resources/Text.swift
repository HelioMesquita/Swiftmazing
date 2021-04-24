//
//  Text.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 03/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

internal enum Text: String {
    case seeMore
    case news
    case topRepos
    case lastUpdated

    public var value: String {
        return String(describing: self.rawValue).localized()
    }

}
