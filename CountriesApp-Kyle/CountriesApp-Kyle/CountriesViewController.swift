//
//  CountriesViewController.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 10/25/23.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var countries = [CountryResponse]()// () - empty by default
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        Task{
            do {
                let countries = try await CountriesAPI.shared.allCountries()
                self.countries = countries
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
        
    }
    

    
    // MARK: - Delegate and Data Source

    // Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        
        return cell
    }

    // Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
     
     

}