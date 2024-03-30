//
//  RepositoryOwner.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

struct RepositoryOwner: Decodable {

  let name: String
  let avatar: URL

  enum CodingKeys: String, CodingKey {
    case name = "login"
    case avatar = "avatar_url"
  }

}
