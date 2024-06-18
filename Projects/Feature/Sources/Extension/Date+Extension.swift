//
//  Date+Extension.swift
//  Feature
//
//  Created by 새미 on 6/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

extension Date {
    func lastWednesday() -> Date {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        var daysToSubtract = 0
        
        switch weekday {
        case 1:
            daysToSubtract = 4
        case 2:
            daysToSubtract = 5
        case 3:
            daysToSubtract = 6
        case 4:
            daysToSubtract = 7
        case 5:
            daysToSubtract = 1
        case 6:
            daysToSubtract = 2
        case 7:
            daysToSubtract = 3
        default:
            break
        }
        
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: self)!
    }
}
