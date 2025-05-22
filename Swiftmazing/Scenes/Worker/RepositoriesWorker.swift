//
//  RepositoriesWorker.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 03/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation
import NetworkLayer

struct RepositoriesWorker {

  let serviceProvider: ServiceProviderProtocol

  init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
    self.serviceProvider = serviceProvider
  }

  func getRepositories(with filter: RepositoriesFilter, page: Int = 1) async throws -> RepositoriesModel {
    let provider = RepositoriesProvider(filter: filter, page: page)
    return try await serviceProvider.execute(request: provider, builder: RepositoryBuilder())
  }

}
