//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import UIKit

final class WeatherDetailViewController: UIViewController {
    static let identifier = "WeatherDetailViewController"
    
    // MARK: - Outlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var sensoryTempLabel: UILabel!
    @IBOutlet weak var tempMinAndMaxLabel: UILabel!
    @IBOutlet weak var otherInfoLabel: UILabel!
    
    // MARK: - ViewProperties
    @objc private let refreshButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.clockwise")
        
        return button
    }()
    
    // MARK: - Properties
    private var weatherModel: CityWeatherInfoModel?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: weatherModel)
        configureNavBar()
    }
    
    // MARK: - Method
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = refreshButton
        refreshButton.target = self
        refreshButton.action = #selector(refreshWeather(_:))
        navigationItem.title = weatherModel?.cityInfo.name
    }
    
    private func configure(with model: CityWeatherInfoModel?) {
        guard let model = model else { return }
        cityNameLabel.text = model.cityInfo.name
        weatherIconImageView.loadImage(index: model.weatherInfo.weather.first!.icon)
        weatherDescriptionLabel.text = model.weatherInfo.weather.first?.weatherDescription
        currentTempLabel.text = model.currentTemp
        sensoryTempLabel.text = model.sensoryTemp
        tempMinAndMaxLabel.text = model.minAndMaxTemp
        otherInfoLabel.text = model.otherInfo
    }
    
    // MARK: - Selector
    @objc private func refreshWeather(_ sender: UIBarButtonItem) {
        guard let weatherModel = weatherModel else { return }

        APICaller.shared.fetchCityWeatherInformation(with: weatherModel.cityInfo)
            .sink { _ in
                
            } receiveValue: { [weak self] model in
                self?.weatherModel = model
            }

    }
}
