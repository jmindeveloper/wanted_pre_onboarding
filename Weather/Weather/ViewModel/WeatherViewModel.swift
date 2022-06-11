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
    let fetchSuccess = PassthroughSubject<Void, Never>()
    
    // 국가통계포털/행정구역분류/한국행정구역분류항목표/영문표기 참고
    private let cities = ["Gongju-si", "Gwangju", "Gumi-si", "Gunsan-si", "Daegu", "Daejeon", "Mokpo-si", "Busan", "Seosan-si", "Seoul", "Sokcho-si", "Suwon-si", "Suncheon-si", "Ulsan", "Iksan-si", "Jeonju-si", "Jeju", "Cheonan-si", "Cheongju-si", "Chuncheon-si"]
    
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchAllCitiesInformation() {
        APICaller.shared.fetchAllWeatherInformation(cities: cities)
            .sink { [weak self] c in
                switch c {
                case .finished:   
                    self?.fetchSuccess.send()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] model in
                self?.cityWeatherInfos = model
            }.store(in: &subscriptions)
    }
}
