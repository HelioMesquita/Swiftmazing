//
//  Repositories.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 26/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import NetworkLayer

struct RepositoriesResponse: Decodable {

  let items: [RepositoryResponse]

}

struct RepositoryResponse: Decodable {

  let name: String
  let stars: Int
  let owner: RepositoryOwnerResponse
  let description: String?
  let issues: Int
  let forks: Int
  let lastUpdate: Date
  let url: URL

  enum CodingKeys: String, CodingKey {
    case name
    case stars = "stargazers_count"
    case owner
    case description
    case issues = "open_issues_count"
    case forks = "forks_count"
    case lastUpdate = "updated_at"
    case url = "html_url"
  }

}

struct RepositoryOwnerResponse: Decodable {

  let name: String
  let avatar: URL

  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatar = "avatar_url"
  }

}
