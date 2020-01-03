//
//  String+Utils.swift
//  Infrastructure
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Foundation

extension String {

    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
