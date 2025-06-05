//
//  States.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/06/25.
//

enum States<T> {
  case loading
  case loaded(T)
  case error(String)
}
