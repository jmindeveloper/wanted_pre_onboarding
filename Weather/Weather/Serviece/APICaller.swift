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
    
    private func fetchCityInformation(with cityName: String) -> AnyPublisher<CityInfoEntity, Error> {
        let urlString = cityInfoBaseUrl + "\(cityName)&limit=1&appid=\(apiKey)"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityInfoFetchResult.self, decoder: JSONDecoder())
            .map { $0.first! }
            .eraseToAnyPublisher()
    }
    
    private func fetchCityWeatherInformation(with city: CityInfoEntity) -> AnyPublisher<CityWeatherInfoModel, Error> {
        let coordinates: Coordinates = (city.lat, city.lon)
        let name = city.localNames.ko
        let urlString = cityWeatherInfoBaseUrl + "lat=\(coordinates.lat)&lon=\(coordinates.lon)&appid=\(apiKey)&lang=kr"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityWeatherInfoEntity.self, decoder: JSONDecoder())
            .map {
                return CityWeatherInfoModel(name: name, weatherInfo: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchAllCityInformation(cities: [String]) -> AnyPublisher<CityInfoEntity, Error> {
        let initialPublisher = fetchCityInformation(with: cities[0])
        let remainder = cities.dropFirst()
        
        return remainder.reduce(initialPublisher) { combined, city in
            return combined
                .merge(with: fetchCityInformation(with: city))
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func fetchAllWeatherInformation(cities: [String]) -> AnyPublisher<[CityWeatherInfoModel], Error> {
        return fetchAllCityInformation(cities: cities)
            .flatMap { [weak self] in
                return self!.fetchCityWeatherInformation(with: $0)
            }
            .scan([]) { models, model -> [CityWeatherInfoModel] in
                return models + [model]
            }
            .map { models in
                models.sorted { $0.name < $1.name }
            }
            .eraseToAnyPublisher()
    }
}