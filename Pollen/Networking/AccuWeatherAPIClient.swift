//
//  ClimaCellAPIClient.swift
//  Pollen
//
//  Created by Jody Kocis on 4/27/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation

class AccuWeatherAPIClient {
    fileprivate let apiKey = "Nx8fVetx3yB9xfvSAql3kICyQFTU1hHK"
    fileprivate let location = "328169"
    fileprivate let getDetails = true
    
    lazy var fiveDayForecastURL: URL = {
        return URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(location)?apikey=\(self.apiKey)&details=\(getDetails)")!
    }()
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias FiveDayForecastCompletionHandler = ([PollenModel]?, Error?) -> Void
    func getFiveDayForecast(completionHandler: @escaping FiveDayForecastCompletionHandler) {
        var request = URLRequest(url: fiveDayForecastURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
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
        )
        dataTask.resume()
    }
    
}
