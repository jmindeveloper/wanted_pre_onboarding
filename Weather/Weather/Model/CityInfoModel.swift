//
//  CityInfoModel.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import Foundation

// MARK: - UnitConvertElement
struct CityInfoModel: Codable {
    let localNames: LocalNames
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case localNames = "local_names"
        case lat, lon
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let ko: String
}

typealias CityInfoFetchResult = [CityInfoModel]
