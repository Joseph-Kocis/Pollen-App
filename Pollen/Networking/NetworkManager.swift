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
    fileprivate var shouldUseNetwork = true
    fileprivate let client = AccuWeatherAPIClient()
    
    @Published var pollenModel: [PollenModel] = []
    
    init() {
        refreshFiveDayForecast()
    }
    
    init(shouldUseNetwork: Bool) {
        self.shouldUseNetwork = shouldUseNetwork
    }
    
    func refreshFiveDayForecast() {
        if shouldUseNetwork {
            client.getFiveDayForecast() { pollenModel, error in
                if let pollenModel = pollenModel {
                    self.pollenModel = pollenModel
                }
                
                // TODO: -- Handle Errors
            }
        }
    }
}
