//
//  RepositoriesModel.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 01/04/24.
//

import Foundation

struct RepositoriesModel {

  let items: [RepositoryModel]

}

class RepositoryModel: Decodable {

  let name: String
  let stars: Int
  let owner: RepositoryOwnerModel
  let description: String?
  let issues: Int
  let forks: Int
  let lastUpdate: Date
  let url: URL

  init(
    name: String, stars: Int, owner: RepositoryOwnerModel, description: String?, issues: Int,
    forks: Int,
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

}

struct RepositoryOwnerModel: Decodable {

  let name: String
  let avatar: URL

}
