//
//  ListModels.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//

import UIComponents
import UIKit

class ListMapRepoViewModel {
  var items: [ListCellViewModel]

  init(repositories: [RepositoryModel]) {
    items = repositories.compactMap { ListCellViewModel(repository: $0) }
  }
}

struct ListCellViewModel: ListCollectionViewModelProtocol {
  let id: String
  let title: String
  let subtitle: String
  let description: String
  let additionalInfo: String
  let supplementaryInfo: String
  let image: URL?
  let repository: RepositoryModel?

  init(repository: RepositoryModel, supplementaryInfo: String = Text.stars.value) {
    self.id = UUID().uuidString
    self.title = repository.name
    self.subtitle = repository.owner.name
    self.description = repository.description ?? ""
    self.image = repository.owner.avatar
    self.repository = repository
    self.additionalInfo = repository.stars.kiloFormat
    self.supplementaryInfo = supplementaryInfo
  }
}
