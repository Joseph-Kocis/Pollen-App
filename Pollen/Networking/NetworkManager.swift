//
//  NetworkManager.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    let client = AccuWeatherAPIClient()
    
    @Published var pollenModel = [PollenModel]()
    
    init() {
        client.getFiveDayForecast() { pollenModel, error in
            if let pollenModel = pollenModel {
                self.pollenModel = pollenModel
            }
            
            // TODO: -- Handle Errors
        }
    }
    
}
