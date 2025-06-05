//
//  RepoDetailViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 05/01/20.
//  Copyright (c) 2020 Hélio Mesquita. All rights reserved.
//

import Combine
import CombineSchedulers
import UIComponents
import UIKit

class RepoDetailViewController: DetailViewController {

  let viewModel: RepoDetailViewModel
  private var cancellables = Set<AnyCancellable>()
  private let scheduler: AnySchedulerOf<DispatchQueue>

  init(
    repository: RepositoryModel,
    scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
  ) {
    viewModel = RepoDetailViewModel(repository: repository)
    self.scheduler = scheduler
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.navigateToNextScreen
      .receive(on: scheduler)
      .sink { action in
        switch action {
        case .openRepository(let url):
          self.openSafari(url)
        }
      }.store(in: &cancellables)

    viewModel.$state
      .receive(on: scheduler)
      .sink { state in
        switch state {
        case .loaded(let model):
          self.setModel(model)
        default:
          break
        }
      }.store(in: &cancellables)

    viewModel.loadScreen()
  }

  func setModel(_ model: RepoDetailModel) {
    self.setImage(model.image)
    self.setTitle(model.title)
    self.setAuthor(model.author)
    self.setDescriptions(model.descriptions)
    self.setButtonTitle(model.buttonTitle)
  }

  func openSafari(_ url: URL) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  override func buttonClicked() {
    viewModel.openRepository()
  }

}
