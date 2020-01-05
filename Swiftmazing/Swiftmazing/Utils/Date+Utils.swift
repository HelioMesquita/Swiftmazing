//
//  Date+Utils.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 05/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Foundation

extension Date {

    var monthDayYear: String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd-yyyy"
        return format.string(from: self)
    }

}
