//
//  AlertDisplayLogic.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 08/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

protocol AlertDisplayLogic: class {
    func showTryAgain(title: String, message: String)
}

extension AlertDisplayLogic where Self: UIViewController {

    func showTryAgain(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Text.tryAgain.value, style: .default) { _ in
            self.interactor?.loadScreen()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }

}
