//
//  URLRequest+Utils.swift
//  Infrastructure
//
//  Created by Helio Loredo Mesquita on 10/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

extension URLRequest {

    init(url: URL?) {
        if let url = url {
            self = URLRequest(url: url)
        }
        fatalError("Invalid URL")
    }

}
