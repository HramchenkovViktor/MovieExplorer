//
//  MovieCell.swift
//  MovieExplorer
//
//  Created by Виктор on 17.11.2026.
//



import UIKit
import SnapKit

final class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private var imageTask: Task<Void, Never>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        posterImageView.backgroundColor = .systemGray4
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.textColor = .systemOrange
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
    }
    
    
    
    private func setupConstraints() {
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageTask?.cancel()
        imageTask = nil
        
        posterImageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
    }
    
    
    
    
    func configure(with movie: Movie) {
        
        imageTask?.cancel()
        imageTask = nil
        
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
        posterImageView.image = nil
        
        guard let posterPath = movie.posterPath else {
            return
        }
        
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageTask = Task { [weak self] in
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard !Task.isCancelled else {
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    return
                }
                
                guard !Task.isCancelled else {
                    return
                }
                
                self?.posterImageView.image = image
                
            } catch {
                if !Task.isCancelled {
                    print("Ошибка загрузки постера: \(error)")
                }
            }
        }
    }
}
