//
//  MainModels.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Visual

enum Main {

    struct Response: Decodable {

        let repositories: [RepositoryDomain]

        enum CodingKeys: String, CodingKey {
            case repositories = "items"
        }

    }

    struct Mapper {

//        static func newsCellViewModel(repositories: [RepositoryDomain]) -> [RepositoryCellViewModel] {
//
//        }

    }
    struct ViewModel {
        var news: [RepositoryCellViewModel] = []
        var repositories: [RepositoryCellViewModel] = []
    }

    struct RepositoryCellViewModel: MainCollectionViewModelProtocol {

        var cellType: MainCollectionViewCell
        var title: String?
        var name: String
        var description: String
        var image: URL?

        init(cellType: MainCollectionViewCell, title: String?, name: String, description: String, image: URL?) {
            self.cellType = cellType
            self.title = title
            self.name = name
            self.description = description
            self.image = image
        }

        init(repository: RepositoryDomain, cellType: MainCollectionViewCell, title: String? = nil) {
            self.cellType = cellType
            self.name = repository.owner.name
            self.description = repository.description
            self.image = repository.owner.avatar
            self.title = title
        }
    }

}
