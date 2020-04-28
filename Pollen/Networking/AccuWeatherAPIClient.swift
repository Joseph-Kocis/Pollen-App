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
        var request = URLRequest(url: Endpoint.fiveDayForecast(withApiKey: apiKey, forLocation: location, withDetails: true).url)
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

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "dataservice.accuweather.com"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension Endpoint {
    static func fiveDayForecast(withApiKey apiKey: String, forLocation location: String,
                                withDetails getDetails: Bool) -> Self {
        Endpoint(
            path: "forecasts/v1/daily/5day/\(location)",
            queryItems: [
                URLQueryItem(name: "apikey", value: apiKey),
                URLQueryItem(name: "details", value: "\(getDetails)")
            ]
        )
    }
}
