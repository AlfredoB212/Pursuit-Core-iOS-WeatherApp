//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Alfredo Barragan on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
final class WeatherAndImageAPIClient {
    final class WeatherAPIClient {
        private init() {}
        static func searchWeather(keyword: String, isZipcode: Bool, completionHandler: @escaping (AppError?, [ForcastData]?) -> Void) {
            var endpointURLString = ""
            if isZipcode {
                endpointURLString = "https://api.aerisapi.com/forecasts/\(keyword)?client_id=\(SecretKeys.weatherID)&client_secret=\(SecretKeys.weatherKey)"
            }
            
            guard let url = URL(string: endpointURLString) else {
                completionHandler(AppError.badURL(endpointURLString), nil)
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler(AppError.networkError(error), nil)
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                        completionHandler(AppError.badStatusCode("\(statusCode)"), nil)
                        return
                }
                if let data = data {
                    do {
                        let weatherForcast = try JSONDecoder().decode(Weather.self, from: data)
                        completionHandler(nil, weatherForcast.response[0].periods)
                    } catch {
                        completionHandler(AppError.jsonDecodingError(error), nil)
                    }
                }
                } .resume()
        }
    }
}
