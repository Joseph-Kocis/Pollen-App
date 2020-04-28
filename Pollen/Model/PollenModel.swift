//
//  PollenModel.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation
import SwiftUI

struct PollenModel {
    var date: Date
    var grassPollenData: PollenData
    var moldPollenData: PollenData
    var treePollenData: PollenData
    var ragweedPollenData: PollenData
}

struct PollenData {
    var pollenType: String
    var amount: Int
    var intensity: Intensity
    
    var intensityColor: Color {
        switch intensity {
            case .low:
                return .green
            case .medium:
                return .yellow
            case .high:
                return .red
        }
    }
    
    var maxAmount: Int {
        switch pollenType {
            case PollenType.grass.rawValue:
                return 20
            case PollenType.mold.rawValue:
                return 60000
            case PollenType.tree.rawValue:
                return 320
            case PollenType.ragweed.rawValue:
                return 10
            default:
                return 10
        }
    }
}

enum PollenType: String {
    case grass = "Grass"
    case mold = "Mold"
    case tree = "Tree"
    case ragweed = "Ragweed"
}

enum Intensity: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Date {
    func formattedDate() -> String {
        if (Calendar.current.isDateInToday(self)) {
            return "Today"
        } else if (Calendar.current.isDateInTomorrow(self)) {
            return "Tomorrow"
        } else if (Calendar.current.isDateInYesterday(self)) {
            return "Yesterday"
        } else if (Calendar.current.isDateInNextSevenDays(self)) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: self)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY"
            return dateFormatter.string(from: self)
        }
    }
}

extension Calendar {
    func isDateInNextSevenDays(_ date: Date) -> Bool {
        if (
            self.isDate(date, inSameDayAs: Date().advanced(by: 1 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 2 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 3 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 4 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 5 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 6 * 86400)) ||
            self.isDate(date, inSameDayAs: Date().advanced(by: 7 * 86400))
            ) {
            return true
        } else {
            return false
        }
    }
}
