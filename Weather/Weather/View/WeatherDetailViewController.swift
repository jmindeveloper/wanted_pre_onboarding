//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    static let identifier = "WeatherDetailViewController"
    
    var weatherModel: CityWeatherInfoModel?
    
    // MARK: - Outlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var tempMinAndMaxLabel: UILabel!
    @IBOutlet weak var otherInfoLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: weatherModel)
        navigationItem.title = weatherModel?.name
    }
    
    // MARK: - Method
    func configure(with model: CityWeatherInfoModel?) {
        guard let model = model else { return }
        cityNameLabel.text = model.name
        weatherIconImageView.loadImage(index: model.weatherInfo.weather.first!.icon)
        weatherDescriptionLabel.text = model.weatherInfo.weather.first?.weatherDescription
        currentTempLabel.text = model.currentTemp
        tempMinAndMaxLabel.text = model.minAndMaxTemp
        otherInfoLabel.text = model.otherInfo
    }
}
