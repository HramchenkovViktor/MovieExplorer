//
//  MovieDetailsViewController.swift
//  MovieExplorer
//
//  Created by Виктор on 17.11.2026.
//


import UIKit
import SnapKit

final class MovieDetailsViewController: UIViewController {

    private let movie: Movie

    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let overviewLabel = UILabel()

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        configure()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "О фильме"

        titleLabel.font = .boldSystemFont(ofSize: 26)
        titleLabel.numberOfLines = 0

        ratingLabel.font = .systemFont(ofSize: 18)
        ratingLabel.textColor = .systemOrange

        releaseDateLabel.font = .systemFont(ofSize: 16)
        releaseDateLabel.textColor = .secondaryLabel

        overviewLabel.font = .systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0

        view.addSubview(titleLabel)
        view.addSubview(ratingLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(overviewLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func configure() {
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ Рейтинг: \(movie.voteAverage)"
        releaseDateLabel.text = "Дата выхода: \(movie.releaseDate)"
        overviewLabel.text = movie.overview
    }
}
