//
//  Repository.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

class Repository: Decodable {

  let name: String
  let stars: Int
  let owner: RepositoryOwner
  let description: String?
  let issues: Int
  let forks: Int
  let lastUpdate: Date
  let url: URL

  init(
    name: String, stars: Int, owner: RepositoryOwner, description: String?, issues: Int, forks: Int,
    lastUpdate: Date, url: URL
  ) {
    self.name = name
    self.stars = stars
    self.owner = owner
    self.description = description
    self.issues = issues
    self.forks = forks
    self.lastUpdate = lastUpdate
    self.url = url
  }

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

struct RepositoryOwner: Decodable {

  let name: String
  let avatar: URL

  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatar = "avatar_url"
  }

}
