//
//  CityWeatherInfoModel.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation

// MARK: - UnitConvert
struct CityWeatherInfoEntity: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let name: String
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

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

// MARK: - Weather
struct Weather: Codable {
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
}

// MARK: - Use
struct CityWeatherInfoModel {
    let name: String
    let weatherInfo: CityWeatherInfoEntity
}