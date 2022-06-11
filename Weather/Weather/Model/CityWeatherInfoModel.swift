//
//  CityWeatherInfoModel.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation

// MARK: - UnitConvert
struct CityWeatherInfoModel: Codable {
//    let coord: Coord
    let weather: [Weather]
//    let base: String
    let main: Main
//    let visibility: Int
    let wind: Wind
    let clouds: Clouds
//    let dt: Int
//    let sys: Sys
//    let timezone, id: Int
//    let name: String
//    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
//struct Coord: Codable {
//    let lon, lat: Double
//}

// MARK: - Main
struct Main: Codable {
    let temp, feelsTemp, tempMin, tempMax: Double // 현재온도, 체감온도, 최소,최대온도
    let pressure, humidity: Int // 기압, 습도

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsTemp = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
//struct Sys: Codable {
//    let country: String
//    let sunrise, sunset: Int
//}

// MARK: - Weather
struct Weather: Codable {
//    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double // 풍속
//    let deg: Int
//    let gust: Double
}

