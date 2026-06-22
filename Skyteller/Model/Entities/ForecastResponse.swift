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
    var temp_c : Float?
    var condition : WeatherCondition?
    var pressure_mb : Float?
    var humidity : Float?
    var feelslike_c : Float?
}

struct WeatherCondition : Codable {
    var text : String?
    var icon : String?
}

struct Forecast : Codable {
    var forecastday : [ForecastDay]?
}

struct ForecastDay : Codable {
    var day : Day?
    var hour : [HourlyForecast]?
}

struct Day : Codable {
    var maxtemp_c : Float?
    var mintemp_c : Float?
    var avgvis_km : Float?
    var condition : WeatherCondition?
}

struct HourlyForecast : Codable {
    var time : String?
    var temp_c : Float?
    var condition : WeatherCondition?
}
