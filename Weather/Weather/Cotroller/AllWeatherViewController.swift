//
//  ViewController.swift
//  Weather
//
//  Created by J_Min on 2022/06/11.
//

import UIKit
import Combine

class AllWeatherViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = WeatherViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
        indicator.startAnimating()
        
        navigationItem.title = "날씨"
        
        configureCombine()
    }
    
    // MARK: - Method
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        tableView.isHidden = true
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshWeather(_:)), for: .valueChanged)
    }
    
    private func configureCombine() {
        viewModel.fetchAllCityWeatherInformations()
        viewModel.fetchAllCityWeatherSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }.store(in: &subscriptions)
    }
    
    // MARK: - Selector
    @objc private func refreshWeather(_ sender: UIRefreshControl) {
        viewModel.fetchAllCityWeatherInformations()
    }
}

// MARK: - UITableViewDatSource
extension AllWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityWeatherInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllWeatherTableViewCell.identifier, for: indexPath) as? AllWeatherTableViewCell else { return UITableViewCell() }
        
        let weatherInfoModel = viewModel.cityWeatherInfos[indexPath.row]
        cell.configure(with: weatherInfoModel)
        
        return cell
    }
}

// MARK: - UITableViewDelagate
extension AllWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: WeatherDetailViewController.identifier) as? WeatherDetailViewController else { return }
        
        let weatherModel = viewModel.cityWeatherInfos[indexPath.row]
        detailVC.weatherModel = weatherModel
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
