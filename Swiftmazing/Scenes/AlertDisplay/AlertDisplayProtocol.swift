//
//  AlertDisplayProtocol.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 08/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

@MainActor
protocol AlertDisplayProtocol: AnyObject {
  func showTryAgain(title: String, message: String)
  func reload()
}

extension AlertDisplayProtocol where Self: UIViewController {

  func showTryAgain(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: Text.tryAgain.value, style: .default) { _ in
      self.reload()
    }
    let tryLater = UIAlertAction(title: Text.tryLater.value, style: .default) { _ in
    }
    alertController.addAction(action)
    alertController.addAction(tryLater)
    present(alertController, animated: true)
  }

}
