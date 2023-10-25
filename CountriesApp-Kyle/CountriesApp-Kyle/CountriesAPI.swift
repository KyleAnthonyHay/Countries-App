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
        let (data, _) = try await urlSession.data(for: urlRequest) //open "URL session" with created request
        // error handling
        let countries = try JSONDecoder().decode([CountryResponse].self, from: data) // Decode data retrieved
        
        return countries
    }
}


struct CountryResponse: Codable {
    //struct for variables
    struct Flag: Codable {
        let png: String
        let svg: String
        let alt: String
    }
    
    struct Name: Codable {
        let common: String
        let official: String
    }
    
    // actual variables
    let name: Name
    let flags: Flag
}
