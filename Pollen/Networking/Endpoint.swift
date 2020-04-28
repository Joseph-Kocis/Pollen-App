//
//  Endpoint.swift
//  Pollen
//
//  Created by Jody Kocis on 4/28/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import Foundation

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

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult func request(_ endpoint: Endpoint,
                                    then handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint.url, completionHandler: handler)
        task.resume()
        return task
    }
}
