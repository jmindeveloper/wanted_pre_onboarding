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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        
        APICaller.shared.fetchCityInformation(with: "Seoul")
            .sink { completion in
                print(completion)
            } receiveValue: { model in
                print(model)
            }.store(in: &subscriptions)
        
        APICaller.shared.fetchCityWeatherInformation(with: (34.9505, 127.4873))
            .sink { completion in
                print(completion)
            } receiveValue: { model in
                print(model)
            }.store(in: &subscriptions)

        
        navigationController?.navigationBar.prefersLargeTitles = true
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
