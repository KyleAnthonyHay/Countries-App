//
//  CountryDetailsViewController.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 11/11/23.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    private let countryName: String
    private var countryData: CountryResponse?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    init(countryName: String){
        self.countryName = countryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                let country = try await CountriesAPI.shared.getCountry(named: countryName)
                countryData = country
                self.tableView.reloadData()
                print(country)
            } catch {
                print(error)
            }
        }

    }
}


extension CountryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return countryData?.languages?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "defaultCell")
        switch indexPath{
        case [0,0]:
            cell.textLabel?.text = countryName
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        case [0,1]:
            let bannerCell = BannerTableViewCell(reuseIdentifier: "bannerCell")
            bannerCell.delagate = self
            guard let url = URL(string: countryData?.flags.png ?? "") else { break }
            bannerCell.loadImage(url: url)
            return bannerCell
        case [0,2]:
            cell.textLabel?.text = "Official Name"
            cell.detailTextLabel?.text = countryData?.name.official
        case [1,0]:
            cell.textLabel?.text = "Capital"
            cell.detailTextLabel?.text = countryData?.capital?.first
        case [1,1]:
            cell.textLabel?.text = "Population"
            cell.detailTextLabel?.text = String(countryData?.population ?? 0)
        case [1,2]:
            guard let currency = countryData?.currencies?.first?.value else {break}
            cell.textLabel?.text = "Currency Name"
            cell.detailTextLabel?.text = currency.name
        case [1,3]:
            guard let currency = countryData?.currencies?.first?.value else {break}
            cell.textLabel?.text = "Currency Symbol"
            cell.detailTextLabel?.text = currency.symbol
        default:
            if indexPath.section == 2 {
                guard let languages = countryData?.languages?.map({$0.1}) else {break}
                cell.textLabel?.text = languages[indexPath.row]
            }
            break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 1:
            return "Country Info"
        case 2:
            return "Languages"
            
        default:
            return nil
        }
    }
}

extension CountryDetailsViewController: BannerTableViewCellDelegate{
    func requestLayoutUpdate() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
}
