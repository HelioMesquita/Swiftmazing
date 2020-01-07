//
//  Repositories.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 26/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

struct Repositories: RequestDecodable {

    let items: [Repository]

    init() {
        items = [Repository(name: "Nmae", stars: 100, owner: RepositoryOwner(name: "name", avatar: URL(string: "https://avatars2.githubusercontent.com/u/6737871?v=4")!), description: "description", issues: 1, forks: 2, lastUpdate: Date())]
    }

}
