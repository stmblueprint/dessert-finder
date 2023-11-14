//
//  DessertsAPIViewModel.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import Foundation



// MARK: this function gets and returns the data from https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert endpoint
func fetchDessertsCategory() async throws -> DessertsAPIModel{
    
    // initialize the endPoint URL for fetching desserts
    let dessertsCategoryEndpoint = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    // convert the endpoint to a valid URL type
    guard let url = URL(string: dessertsCategoryEndpoint) else {
        throw DessertsAPIError.invalidURL
    }
    
    // asynchronously fetch data from the URL using URLSession
    let (data, response) = try await URLSession.shared.data(from: url)
    
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        if let httpResponse = response as? HTTPURLResponse {
            // Handle HTTP status errors
            if httpResponse.statusCode == 502 {
                throw DessertsAPIError.badGateway
            } else {
                throw DessertsAPIError.invalidResponse
            }
        } else {
            // Handle non-HTTP response errors
            throw DessertsAPIError.nonHttpError
        }
    }
    
    // see the data being fetched in the console
    if let dataString = String(data: data, encoding: .utf8) {
           print("Fetched data: \(dataString)")
    }
    
    do {
        let decoder = JSONDecoder() // initialize decoder
        decoder.keyDecodingStrategy = .convertFromSnakeCase // key decoding strategy
        
        // Decode the JSON data into a DessertsAPIModel object
        return try decoder.decode(DessertsAPIModel.self, from: data)
        
    } catch {
        throw DessertsAPIError.invalidData  // handle data decoding errors
    }
}


// MARK: this function gets and returns the data from https://themealdb.com/api/json/v1/1/lookup.php?i=\(id) endpoint
func fetchDessertDetails(_ id: String) async throws -> DessertsDetailsAPIModel {
    
    let dessertsDetailsEndpoint = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
    
    guard let url = URL(string: dessertsDetailsEndpoint) else {
        throw DessertsAPIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        
        throw DessertsAPIError.invalidResponse
    }
    
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(DessertsDetailsAPIModel.self, from: data)
        
    } catch {
        if let dataString = String(data: data, encoding: .utf8) {
               print("Fetched data: \(dataString)")
        }
        throw DessertsAPIError.invalidData

    }
}
