//
//  RepositoriesWorkerSpy.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

@testable import Swiftmazing
@testable import PromiseKit

class RepositoriesWorkerSpy: RepositoriesWorker {

    var isSuccess = true

    override func getRepositories(with filter: Filter, page: Int = 1) -> Promise<Repositories> {
        return Promise<Repositories> { seal in
            if isSuccess {
                seal.fulfill(Repositories())
            } else {
                seal.reject(NSError(domain: "", code: 0))
            }
        }
    }

}
