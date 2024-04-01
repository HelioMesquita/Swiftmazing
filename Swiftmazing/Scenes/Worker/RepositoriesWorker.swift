//
//  RepositoriesWorker.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 03/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//
// CUCKOO_TESTABLE

import Foundation
import Infrastructure

class RepositoriesWorker {

  let serviceProvider: ServiceProviderProtocol

  init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
    self.serviceProvider = serviceProvider
  }

  func getRepositories(with filter: Filter, page: Int = 1) async throws -> Repositories {
    let provider = RepositoriesProvider(filter: filter, page: page)
    return try await serviceProvider.execute(request: provider, parser: Repositories.self)
  }

}
