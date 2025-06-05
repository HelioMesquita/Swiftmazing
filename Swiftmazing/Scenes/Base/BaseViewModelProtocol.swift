//
//  BaseViewModelProtocol.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/06/25.
//

import Combine

@MainActor
protocol BaseViewModelProtocol {
  associatedtype T
  var statePublisher: AnyPublisher<T, Never> { get }
  func loadScreen()
}
