//
//  RepositoriesWorkerSpy.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

@testable import Swiftmazing

struct RepositoriesWorkerSpy: RepositoriesWorkerProtocol {

  var isSuccess: Bool

  init(isSuccess: Bool = true) {
    self.isSuccess = isSuccess
  }

  func getRepositories(with filter: RepositoriesFilter, page: Int = 1) async throws
    -> RepositoriesModel
  {
    if isSuccess {
      return RepositoriesModel(items: [])
    } else {
      throw NSError(domain: "", code: 0)
    }
  }

}
