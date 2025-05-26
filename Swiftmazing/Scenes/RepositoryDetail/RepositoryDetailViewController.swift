//
//  RepositoryDetailViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 05/01/20.
//  Copyright (c) 2020 Hélio Mesquita. All rights reserved.
//

import Combine
import UIKit
import UIComponents

class RepositoryDetailViewController: DetailViewController {

  let viewModel: RepositoryDetailViewModel
  private var cancellables = Set<AnyCancellable>()

  init(repository: RepositoryModel) {
    viewModel = RepositoryDetailViewModel(repository: repository)
    super.init()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.navigateToNextScreen
      .sink { action in
        switch action {
        case .openRepository(let url):
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
      }.store(in: &cancellables)

    viewModel.$state
      .receive(on: RunLoop.main)
      .sink { state in
        switch state {
        case .loaded(let model):
          self.setImage(model.image)
          self.setTitle(model.title)
          self.setAuthor(model.author)
          self.setDescriptions(model.descriptions)
          self.setButtonTitle(model.buttonTitle)
        default:
          break
        }
      }.store(in: &cancellables)

    viewModel.loadScreen()
  }

  override func buttonClicked() {
    viewModel.openRepository()
  }

}
