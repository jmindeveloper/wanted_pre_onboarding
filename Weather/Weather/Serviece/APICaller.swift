//
//  APICaller.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation
import Combine

typealias Coordinates = (lat: Double, lon: Double)

final class APICaller {
    static let shared = APICaller()
    private let cityInfoBaseUrl = "http://api.openweathermap.org/geo/1.0/direct?q="
    private let cityWeatherInfoBaseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    private let apiKey = "8d48a534e2b76a5b453fd949f1a0efa2"
    
    private init() { }
    
    func fetchCityInformation(with cityName: String) -> AnyPublisher<[CityInfoModel], Error> {
        
        let urlString = cityInfoBaseUrl + "\(cityName)&limit=1&appid=\(apiKey)"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityInfoFetchResult.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchCityWeatherInformation(with coordinates: Coordinates) -> AnyPublisher<CityWeatherInfoModel, Error> {
        let urlString = cityWeatherInfoBaseUrl + "lat=\(coordinates.lat)&lon=\(coordinates.lon)&appid=\(apiKey)&lang=kr"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityWeatherInfoModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
