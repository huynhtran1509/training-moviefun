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
        movieImage.af_cancelImageRequest()
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
        let sizeOption = "w500"
        let imagePath = "https://image.tmdb.org/t/p/\(sizeOption)/\(path)"
        let fileUrl = URL(string: imagePath)
        if let imageMovie = fileUrl {
            // alamofire charged to do the dequeue
            movieImage.af_setImage(withURL: imageMovie)
        }
        movieTitleLabel.text = movie.title
        
        // Convert the int genres ids to string
        var genresList = [String]()
        
        movie.genresIds.forEach { genre in
            let id = genre.genreId
            let genreName = GenreManager.instance.valueFromGenreId(genreId: id)
            genresList.append(genreName)
        }
        
        releaseDateGenreLabel.text = movie.releaseDate.year() + " - " + genresList.description
        popularityLabel.text = "Popularity: " + movie.voteAverage.description
        descriptionLabel.text = movie.overview
    }

}
