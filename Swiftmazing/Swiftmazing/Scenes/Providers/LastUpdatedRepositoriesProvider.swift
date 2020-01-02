//
//  LastUpdatedRepositoriesProvider.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

class LastUpdatedRepositoriesProvider: BaseRepositoriesProvider {

    init() {
        super.init(filter: .updated)
    }

}
