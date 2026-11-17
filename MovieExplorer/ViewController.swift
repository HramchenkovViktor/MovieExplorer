//
//  ViewController.swift
//  MovieExplorer
//
//  Created by Виктор on 16.11.2026.
//



import UIKit

final class ViewController: UIViewController {

    private let networkManager = NetworkManager(
        token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTk2ODNhZGVlMDhjMzExMDU5NTU2OWVhMTBlYzM5MSIsIm5iZiI6MTc5NDgzNjc0Ny41NTcsInN1YiI6IjZhZmIwOTBiOGQwNTEzYzNmNzZkMGQwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eDpsZ5MjEJVmxZR5aPf5RH-Gg76zAgzjJtWykmbrpeA"
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        Task {
            await loadMovies()
        }
    }

    private func loadMovies() async {
        do {
            let movies = try await networkManager.fetchMovies()

            for movie in movies {
                print("Название: \(movie.title)")
                print("Рейтинг: \(movie.voteAverage)")
                print("---------------------")
            }

        } catch {
            print("Ошибка: \(error)")
        }
    }
}

