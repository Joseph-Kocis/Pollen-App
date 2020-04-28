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
