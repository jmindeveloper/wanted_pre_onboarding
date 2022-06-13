//
//  WeatherViewModel.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation
import Combine

final class WeatherViewModel {
    
    // MARK: - Properties
    private(set) var cityWeatherInfos = [CityWeatherInfoModel]()
    private(set) var oneCityWeatherInfo: CityWeatherInfoModel?
    let fetchAllCityWeatherSuccess = PassthroughSubject<Void, Never>()
    let fetchOneCityWeatherSuccess = PassthroughSubject<Void, Never>()
    
    // 국가통계포털/행정구역분류/한국행정구역분류항목표/영문표기 참고
    private(set) var cities = ["Gongju-si", "Gwangju", "Gumi-si", "Gunsan-si", "Daegu", "Daejeon", "Mokpo-si", "Busan", "Seosan-si", "Seoul", "Sokcho-si", "Suwon-si", "Suncheon-si", "Ulsan", "Iksan-si", "Jeonju-si", "Jeju", "Cheonan-si", "Cheongju-si", "Chuncheon-si"]
    
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchAllCityWeatherInformations() {
        APICaller.shared.fetchAllWeatherInformation(cities: cities)
            .sink { [weak self] c in
                switch c {
                case .finished:
                    self?.fetchAllCityWeatherSuccess.send()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.cityWeatherInfos = model
            }.store(in: &subscriptions)
    }
    
    func refreshOneCityWeatherInformation(with city: CityInfoModel) {
        APICaller.shared.fetchCityWeatherInformation(with: city)
            .sink { [weak self] c in
                switch c {
                case .finished:
                    self?.fetchOneCityWeatherSuccess.send()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.oneCityWeatherInfo = model
            }.store(in: &subscriptions)
    }
}
