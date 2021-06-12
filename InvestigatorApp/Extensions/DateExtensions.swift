//
//  DateExtensions.swift
//  InvestigatorApp
//
//  Created by Артём on 6/12/21.
//

import Foundation

extension Date {

    func toString(format: String = "dd-MM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
