//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Biron Su on 1/22/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class WeatherAPIClient{
    static func getWeather(keyword: String, completionHandler: @escaping (AppError?, [WeatherInfo]?) -> Void) {
        let getWeatherEndpoint = "https://api.aerisapi.com/forecasts/\(keyword)?client_id=\(SecretKeys.AccessID)&client_secret=\(SecretKeys.APIKey)"
        NetworkHelper.shared.performDataTask(endpointURLString: getWeatherEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    var weather = try JSONDecoder().decode(Weather.self, from: data)
                    completionHandler(nil,weather.response[0].periods)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}