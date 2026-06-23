//
//  WeatherResponse.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 21/06/2026.
//

import Foundation

struct ForecastResponse : Codable {
    var location : Location?
    var current : CurrentForecast?
    var forecast : Forecast?
}

struct Location : Codable {
    var name : String?
}

struct CurrentForecast : Codable {
    var temp_c : Double?
    var condition : WeatherCondition?
    var pressure_mb : Double?
    var humidity : Int?
    var feelslike_c : Double?
    var vis_km : Double?
}

struct WeatherCondition : Codable {
    var text : String?
    var icon : String?
}

struct Forecast : Codable {
    var forecastday : [ForecastDay]?
}

struct ForecastDay : Codable {
    var date : String?
    var day : Day?
    var hour : [HourlyForecast]?
}

struct Day : Codable {
    var maxtemp_c : Double?
    var mintemp_c : Double?
    var avgvis_km : Double?
    var condition : WeatherCondition?
}

struct HourlyForecast : Codable {
    var time : String?
    var temp_c : Double?
    var condition : WeatherCondition?
}
