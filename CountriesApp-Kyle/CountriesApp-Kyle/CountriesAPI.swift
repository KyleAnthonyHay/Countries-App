//
//  CountriesAPI.swift
//  CountriesApp-Kyle
//
//  Created by Kyle-Anthony Hay on 10/25/23.
//

import Foundation

struct CountriesAPI{
    
    static let shared = CountriesAPI()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    //API Request
    func allCountries() async throws -> [CountryResponse]{
        let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,flags")!// create URL
        let urlRequest = URLRequest(url: url)// create request from URL
        let (data, response) = try await urlSession.data(for: urlRequest) //open "URL session" with created request
        
        // error handling
        guard let response = response as? HTTPURLResponse else {
                    throw CountriesAPIError.requestFailed(message: "Response is not HTTPURLResponse.")
                }

                guard 200...299 ~= response.statusCode else {
                    throw CountriesAPIError.requestFailed(message: "Status Code should be 2xx, but is \(response.statusCode).")
                }
        
        let countries = try JSONDecoder().decode([CountryResponse].self, from: data) // Decode data retrieved
        
        return countries
    }
    
    func getCountry(named countryName: String) async throws -> CountryResponse {
        let url = URL(string: "https://restcountries.com/v3.1/name/\(countryName)")!
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest) //open "URL session" with created request
        
        // error handling
        guard let response = response as? HTTPURLResponse else {
                    throw CountriesAPIError.requestFailed(message: "Response is not HTTPURLResponse.")
                }

                guard 200...299 ~= response.statusCode else {
                    throw CountriesAPIError.requestFailed(message: "Status Code should be 2xx, but is \(response.statusCode).")
                }
        let country = try JSONDecoder().decode([CountryResponse].self, from: data).first(where: {$0.name.common == countryName}) // this returns an array so we .first to collect the first/only element
        
        return country!
    }
}


struct CountryResponse: Codable {
    //struct for variables
    struct Flag: Codable {
        let png: String
        let svg: String
        let alt: String?
    }
    
    struct Name: Codable {
        let common: String
        let official: String
    }
    
    // actual variables
    let name: Name
    let flags: Flag
    
    // getCountry(:named) variables
    struct Currency: Codable {
        let name: String
        let symbol: String
    }
    
    let population: Int?
    let currencies: [String: Currency]? //dictionary
    let languages: [String: String]?
    let capital: [String]?
    
}

// MARK: Error Handling
enum CountriesAPIError: Error{
    case requestFailed(message: String)
}
