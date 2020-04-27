//
//  PollenModel.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation

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
}

enum Intensity: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
