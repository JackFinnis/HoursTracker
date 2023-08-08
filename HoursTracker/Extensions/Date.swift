//
//  Date.swift
//  HoursTracker
//
//  Created by Jack Finnis on 08/08/2023.
//

import Foundation

extension Date {
    var intervalToNow: TimeInterval {
        Date.now.timeIntervalSince(self)
    }
}
