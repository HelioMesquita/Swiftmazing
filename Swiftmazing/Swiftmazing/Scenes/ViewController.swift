//
//  ViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 08/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import Infrastructure

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(RequestError.notFound.localizedDescription)

        



        
        // Do any additional setup after loading the view.
    }


}

class SwiftRepositoriesProvider: RequestProviderProtocol {
    var path: String = "/search/repositories"

    var httpVerb: HttpVerbs = .GET


}
