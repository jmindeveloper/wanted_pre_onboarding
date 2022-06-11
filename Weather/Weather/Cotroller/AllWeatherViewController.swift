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
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = WeatherViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        
        configureCombine()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Method
    private func configureCombine() {
        viewModel.fetchAllCitiesInformation()
        viewModel.fetchSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                print("tableView.reloadData")
            }.store(in: &subscriptions)
    }
}

// MARK: - UITableViewDatSource
extension AllWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllWeatherTableViewCell.identifier, for: indexPath) as? AllWeatherTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelagate
extension AllWeatherViewController: UITableViewDelegate {

}
