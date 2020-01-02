//
//  Repository.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

struct Repository: Decodable {

    let name: String
    let stars: Int
    let owner: RepositoryOwner
    let description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case stars = "stargazers_count"
        case owner
        case description
    }

}
