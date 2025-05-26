//
//  MainModels.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import UIComponents

class FeedModel {
  let news: [FeedCellModel]
  let topRepos: [FeedCellModel]
  let lastUpdated: [FeedCellModel]

  init(news: MapNewsViewModel, topRepos: MapRepoViewModel, lastUpdated: MapRepoViewModel) {
    self.news = news.items
    self.topRepos = topRepos.items
    self.lastUpdated = lastUpdated.items
  }
}

struct FeedCellModel: FeedCollectionViewModelProtocol {
  var id: String
  var title: String
  var subtitle: String?
  var description: String
  var images: [URL]
  var additionalInfo: String?
  var supplementaryInfo: String?

  var section: FeedSection
  var repository: RepositoryModel?

  init(title: String, subtitle: String, description: String, section: FeedSection, images: [URL])
  {
    self.id = UUID().uuidString
    self.title = title
    self.subtitle = subtitle
    self.description = description
    self.images = images
    self.section = section
  }

  init(
    repository: RepositoryModel, section: FeedSection,
    supplementaryInfo: String = Text.stars.value
  ) {
    self.id = UUID().uuidString
    self.title = repository.name
    self.description = repository.owner.name
    self.additionalInfo = repository.stars.kiloFormat
    self.supplementaryInfo = supplementaryInfo
    self.images = [repository.owner.avatar]
    self.section = section
    self.repository = repository
  }
}

class MapRepoViewModel {
  var items: [FeedCellModel]

  init(repositories: [RepositoryModel], section: FeedSection) {
    items = repositories.compactMap { FeedCellModel(repository: $0, section: section) }
  }
}

class MapNewsViewModel {
  var items: [FeedCellModel]

  init(topRepos: [RepositoryModel], lastUpdated: [RepositoryModel]) {
    let topAvatars = topRepos.compactMap { $0.owner.avatar }
    let lastAvatars = lastUpdated.compactMap { $0.owner.avatar }
    items = [
      FeedCellModel(
        title: Text.bestRepositories.value,
        subtitle: Text.renownedRepositories.value,
        description: Text.bestTools.value,
        section: .topRepos,
        images: topAvatars),
      FeedCellModel(
        title: Text.updatedRepositories.value,
        subtitle: Text.theLatestUpdates.value,
        description: Text.mostUpdatedRepositories.value,
        section: .lastUpdated,
        images: lastAvatars),
    ]
  }
}
