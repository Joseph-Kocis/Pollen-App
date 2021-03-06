//
//  ClimaCellAPIClient.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation

class AccuWeatherAPIClient {
    fileprivate let apiKey = "vd5TFuMzvwKnvTv2LCtGVMqBNB8eGaNX"
    fileprivate let location = "328169"
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias FiveDayForecastCompletionHandler = ([PollenModel]?, Error?) -> Void
    func getFiveDayForecast(then completionHandler: @escaping FiveDayForecastCompletionHandler, using session: URLSession = .shared) {
        
        session.request(.fiveDayForecast(withApiKey: apiKey, forLocation: location,
                                         withDetails: true)) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            do {
                let weatherModel = try self.decoder.decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    let mappedPollenModel = weatherModel.mapToPollenModel()
                    completionHandler(mappedPollenModel.pollenModel, mappedPollenModel.error)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
    }
    
}
