//
//  MovieTableViewCell.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/8/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateGenreLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //Reset existing data
        movieImage.image = nil
        movieTitleLabel.text = nil
        releaseDateGenreLabel.text = nil
        popularityLabel.text = nil
        descriptionLabel.text = nil
    }
    
    // MARK: - Movie cell configuration
    func configuration(with movie: Movie ) {
        // Convert string image path to URL
        guard let path = movie.imagePath else { return }
        let imagePath: String = "https://image.tmdb.org/t/p/original" + path
        let fileUrl = URL(string: imagePath)
        if let imageMovie = fileUrl {
            DispatchQueue.global(qos: .background).async { [weak self] in
                do {
                    let imageData = try Data(contentsOf: imageMovie as URL)
                    DispatchQueue.main.async {
                        self?.movieImage.image = UIImage(data: imageData)
                    }
                } catch {
                    print(error)
                }
            }
        }
        movieTitleLabel.text = movie.title
        
        // Convert the int genres ids to string
        let cantGenres = movie.genresIds.count
        var genresList = [String]()
        for index in 0...cantGenres-1 {
            let id = movie.genresIds[index].genreId
            let genreName = GenreManager.instance.valueFromGenreId(genreId: id)
            genresList.append(genreName)
        }
        
        releaseDateGenreLabel.text = movie.releaseDate.year() + " - " + genresList.description
        popularityLabel.text = "Popularity: " + movie.voteAverage.description
        descriptionLabel.text = movie.overview
    }

}
