//
//  Repository.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation
import Infrastructure

class RepositoryBuilder: BuilderProviderProtocol {

  func build(response: RepositoriesResponse) throws -> RepositoriesModel {
    let items = response.items.compactMap { repository in
      let owner = RepositoryOwnerModel(name: repository.owner.name, avatar: repository.owner.avatar)
      return RepositoryModel(
        name: repository.name, stars: repository.stars, owner: owner,
        description: repository.description, issues: repository.issues, forks: repository.forks,
        lastUpdate: repository.lastUpdate, url: repository.url)
    }
    return RepositoriesModel(items: items)
  }

}
