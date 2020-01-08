//
//  Repositories.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 26/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import Infrastructure

struct Repositories: RequestDecodable {

    let items: [Repository]

    init() {
        let image = URL(string: "https://avatars3.githubusercontent.com/u/25267226?s=400&v=4")!

        items = [Repository(name: "swiftmazing", stars: 100, owner: RepositoryOwner(name: "Helio Mesquita", avatar: image), description: "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.", issues: 1, forks: 2, lastUpdate: Date()),]
    }

}
