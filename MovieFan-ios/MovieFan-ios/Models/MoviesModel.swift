//
//  Movies.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/1/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Decodable
import Foundation
import Opera

final class Movie {
    
    var id: Int = 0
    var title: String?
    var genres: [Int] = []
    var releaseDate: Date = Date()
    var imagePath: String?
    var voteAverage: Int?
    
    convenience init(id: Int, title: String?, genres: [Int], releaseDate: Date, imagePath: String?, voteAverage: Int?) {
        self.init()
        
        self.id = id
        self.title = title
        self.genres = genres
        self.releaseDate = releaseDate
        self.imagePath = imagePath
        self.voteAverage = voteAverage
    }
    
}

extension Movie: Decodable, OperaDecodable {
        
    static func decode(_ data: Any) throws -> Movie {
        return try Movie(id: data => "id",
                        title: data => "title",
                        genres: data => "genre_ids",
                        releaseDate: data => "release_date",
                        imagePath: data =>? "poster_path",
                        voteAverage: data =>? "vote_average")
    }

}
