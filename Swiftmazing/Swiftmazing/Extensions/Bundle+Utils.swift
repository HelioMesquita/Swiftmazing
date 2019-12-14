//
//  Bundle+Utils.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

extension Bundle {

  var scheme: String {
    return self.object(forInfoDictionaryKey: "Scheme") as! String
  }

  var host: String {
    return self.object(forInfoDictionaryKey: "Host") as! String
  }

}
