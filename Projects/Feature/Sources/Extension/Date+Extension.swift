//
//  Date+Extension.swift
//  Feature
//
//  Created by 새미 on 6/11/24.
//  Copyright © 2024 HARIBO. All rights reserved.
//

import Foundation

extension Date {
    func recentWednesday() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear, .weekday], from: self)
        components.weekday = 4
        
        guard let recentWednesday = calendar.nextDate(after: self, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward) else {
            return self
        }
        return recentWednesday
    }
}
