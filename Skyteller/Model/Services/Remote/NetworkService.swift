//
//  Network Services.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 22/06/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchForecastByCity(cityName: String, completion: @escaping (ForecastResponse?, Error?) -> Void)
    func fetchForecastByLocation(long: Double, lat: Double, completion: @escaping (ForecastResponse?, Error?) -> Void)
}

class NetworkService : NetworkServiceProtocol {
    func fetchForecastByCity(cityName: String, completion: @escaping (ForecastResponse?, Error?) -> Void) {
        let urlString = "http://api.weatherapi.com/v1/forecast.json"
        
        let parameters: [String: String] = [
            "key": "dea033bbd53b47efbbf181343261706",
            "q": cityName,
            "days": "3",
            "aqi": "yes",
            "alerts": "no"
        ]
        
        AF.request(urlString, method: .get, parameters: parameters)
            .responseDecodable(of: ForecastResponse.self) { response in
                
                switch response.result {
                case .success(let forecastResponse):
                    
                    completion(forecastResponse, nil)
                    
                case .failure(let error):
                    
                    completion(nil, error)
                }
            }
    }
    
    func fetchForecastByLocation(long: Double, lat: Double, completion: @escaping (ForecastResponse?, Error?) -> Void) {
        let urlString = "http://api.weatherapi.com/v1/forecast.json"
        
        let location = "\(lat),\(long)"
        
        let parameters: [String: String] = [
            "key": "dea033bbd53b47efbbf181343261706",
            "q": location,
            "days": "3",
            "aqi": "yes",
            "alerts": "no"
        ]
        
        AF.request(urlString, method: .get, parameters: parameters)
            .responseDecodable(of: ForecastResponse.self) { response in
                
                switch response.result {
                case .success(let forecastResponse):
                    
                    completion(forecastResponse, nil)
                    
                case .failure(let error):
                    
                    completion(nil, error)
                }
            }
    }
    
    
}
