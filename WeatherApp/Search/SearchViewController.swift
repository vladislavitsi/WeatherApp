//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class SearchViewController: UIViewController {

    private let cellHeight = CGFloat(70)
    
    weak var parentVC: ViewController?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    let searchResults = SearchResult()

    @IBAction func backGesture(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        

         searchBar.reactive.continuousTextValues
            .skipNil()
            .filter { $0.isEmpty == false }
            .throttle(0.5, on: QueueScheduler.main)
            .observeValues { value in
                WeatherNetworker.getData(for: .searchUrl, arguments: value).startWithValues { [weak self] (searchResult: SearchResult) in
                    self?.searchResults.weatherDataCollection.value = searchResult.weatherDataCollection.value
                }
            }
        
        searchBar.reactive.continuousTextValues
            .skipNil()
            .filter { $0.isEmpty }
            .observeValues{ [weak self] value in
                self?.searchResults.weatherDataCollection.value.removeAll()
            }
        searchResults.weatherDataCollection.signal
            .observe {[weak self] _ in
                self?.table.reloadData()
            }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.weatherDataCollection.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let weatherData = searchResults.weatherDataCollection.value[indexPath.row]
        cell.viewModel.value = weatherData
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parentVC?.currentWeatherData.value = searchResults.weatherDataCollection.value[indexPath.row]
        dismiss(animated: true)
    }
}
