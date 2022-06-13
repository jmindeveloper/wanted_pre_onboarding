//
//  AllWeatherTableViewCell.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import UIKit

final class AllWeatherTableViewCell: UITableViewCell {
    static let identifier = "AllWeatherTableViewCell"
    
    // MARK: - Outlet
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    // MARK: - Method
    func configure(with model: CityWeatherInfoModel) {
        cityNameLabel.text = model.cityInfo.name
        currentWeatherLabel.text = String(model.currentTampAndHumidity)
        weatherIconImageView.loadImage(index: model.weatherInfo.weather.first!.icon)
    }
    
    override func prepareForReuse() {
        weatherIconImageView.image = nil
    }
}
