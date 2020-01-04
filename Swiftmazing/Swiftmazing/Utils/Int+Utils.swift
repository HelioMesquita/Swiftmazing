//
//  Int+Utils.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

extension Int {

    var kiloFormat: String {
        if self > 1000 {
            var result: String = ""
            let remainder = self / 1000
            result += "\(remainder)"

            let quotient = self % 1000
            let remainderQuotient = quotient / 100

            if remainderQuotient > 0 {
                result += ".\(remainderQuotient)k"
            } else {
                result += "k"
            }
            return result
        } else {
            return String(describing: self)
        }
    }

}
