//
//  Double.swift
//  HoursTracker
//
//  Created by Jack Finnis on 08/08/2023.
//

import Foundation

extension Double {
    func formattedInterval() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: self) ?? ""
    }
}
