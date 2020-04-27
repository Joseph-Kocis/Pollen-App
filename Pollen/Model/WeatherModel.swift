//
//  WeatherModel.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation

public struct WeatherModel: Decodable {
    let dailyForecast: [Day]
    
    public struct Day: Decodable {
        let date: String
        let airAndPollen: [AirAndPollen]
        
        public struct AirAndPollen: Decodable {
            let name: String
            let value: Int
            let category: String
            let categoryValue: Int
            
            private enum CodingKeys: String, CodingKey {
                case name = "Name"
                case value = "Value"
                case category = "Category"
                case categoryValue = "CategoryValue"
            }
        }
        private enum CodingKeys: String, CodingKey {
            case date = "Date"
            case airAndPollen = "AirAndPollen"
        }
    }
    private enum CodingKeys: String, CodingKey {
        case dailyForecast = "DailyForecasts"
    }
    
    func mapToPollenModel() -> (pollenModel: [PollenModel]?, error: Error?){
        var pollenModel: [PollenModel] = []
        self.dailyForecast.forEach() { currentDay in
            let airAndPollenData = currentDay.airAndPollen
            
            var grassPollenData: PollenData?
            var moldPollenData: PollenData?
            var treePollenData: PollenData?
            var ragweedPollenData: PollenData?
            
            airAndPollenData.forEach { pollenData in
                var intensity = Intensity.low
                if (pollenData.categoryValue == 2) {
                    intensity = .medium
                } else if (pollenData.categoryValue == 3) {
                    intensity = .high
                }
                
                if (pollenData.name == "Grass") {
                    grassPollenData = PollenData(
                        pollenType: "Grass",
                        amount: pollenData.value,
                        intensity: intensity
                    )
                } else if (pollenData.name == "Mold") {
                    moldPollenData = PollenData(
                        pollenType: "Mold",
                        amount: pollenData.value,
                        intensity: intensity
                    )
                } else if (pollenData.name == "Tree") {
                    treePollenData = PollenData(
                        pollenType: "Tree",
                        amount: pollenData.value,
                        intensity: intensity
                    )
                } else if (pollenData.name == "Ragweed") {
                    ragweedPollenData = PollenData(
                        pollenType: "Ragweed",
                        amount: pollenData.value,
                        intensity: intensity
                    )
                }
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let day = PollenModel(
                date: dateFormatter.date(from: currentDay.date) ?? Date(),
                grassPollenData: grassPollenData!,
                moldPollenData: moldPollenData!,
                treePollenData: treePollenData!,
                ragweedPollenData: ragweedPollenData!
            )
            
            pollenModel.append(day)
        }
        
        return (pollenModel, nil)
    }
}
