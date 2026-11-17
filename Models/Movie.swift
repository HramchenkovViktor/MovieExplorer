//
//  Movie.swift
//  MovieExplorer
//
//  Created by Виктор on 16.11.2026.
//


import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String?
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
