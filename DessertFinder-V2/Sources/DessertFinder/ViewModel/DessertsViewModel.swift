//
//  DessertsAPIViewModel.swift
//  DessertFinder
//
//  Created by Aaron Tulloch on 11/6/23.
//

import Foundation



enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case badGateway
    case nonHttpError
}

class NetworkingManager {
    static let shared = NetworkingManager()

    private init() {}

    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkingError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            if httpResponse.statusCode == 502 {
                throw NetworkingError.badGateway
            } else {
                throw NetworkingError.invalidResponse
            }
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            if let dataString = String(data: data, encoding: .utf8) {
                print("Fetched data: \(dataString)")
            }
            throw NetworkingError.invalidData
        }
    }
}

