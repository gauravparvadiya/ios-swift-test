//
//  Date+DateFormatter.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

extension Date {
    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    func getYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
}
