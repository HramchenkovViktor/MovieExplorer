//
//  MovieViewControllers.swift
//  MovieExplorer
//
//  Created by Виктор on 17.11.2026.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController {

   

    private var movies: [Movie] = []
    private let networkManager = NetworkManager(
        token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTk2ODNhZGVlMDhjMzExMDU5NTU2OWVhMTBlYzM5MSIsIm5iZiI6MTc5NDgzNjc0Ny41NTcsInN1YiI6IjZhZmIwOTBiOGQwNTEzYzNmNzZkMGQwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eDpsZ5MjEJVmxZR5aPf5RH-Gg76zAgzjJtWykmbrpeA"
    )

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

   

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupCollectionView()
     
        Task {
                await loadMovies()
            }
    }

   

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Фильмы"

        view.addSubview(collectionView)
    }

    

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            MovieCell.self,
            forCellWithReuseIdentifier: MovieCell.identifier
        )
    }
    
    private func loadMovies() async {
        do {
            let loadedMovies = try await networkManager.fetchMovies()

            movies = loadedMovies

            collectionView.reloadData()

        } catch {
            print("Ошибка загрузки фильмов: \(error)")
        }
    }

}



extension MoviesViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCell.identifier,
            for: indexPath
        ) as? MovieCell else {
            return UICollectionViewCell()
        }

        let movie = movies[indexPath.item]
        cell.configure(with: movie)

        return cell
    }
}



extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let spacing: CGFloat = 12
        let width = (collectionView.bounds.width - spacing * 3) / 2

        return CGSize(width: width, height: 310)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedMovie = movies[indexPath.item]

        let detailsViewController = MovieDetailsViewController(
            movie: selectedMovie
        )

        navigationController?.pushViewController(
            detailsViewController,
            animated: true
        )
    }

}
