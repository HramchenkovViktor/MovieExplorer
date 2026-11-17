//
//  Network.swift
//  MovieExplorer
//
//  Created by Виктор on 16.11.2026.
//


import Foundation

final class NetworkManager {

    private let token: String

    init(token: String) {
        self.token = token
    }

    func fetchMovies() async throws -> [Movie] {

        guard let url = URL(
            string: "https://api.themoviedb.org/3/movie/popular?language=ru-RU&page=1"
        ) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "accept"
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            print("HTTP ошибка: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let movieResponse = try decoder.decode(
            MovieResponse.self,
            from: data
        )

        return movieResponse.results
    }
}

