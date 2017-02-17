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
import RealmSwift

final class Movie: Object {

    // Array of genres Id
    let genresIds = List<IntObject>()
    
    dynamic var id: Int = 0
    dynamic var title: String?
    dynamic var releaseDate: Date = Date()
    dynamic var imagePath: String?
    dynamic var voteAverage: Int = 0
    dynamic var overview: String?
    
    // MARK: - Initialization
    convenience init(id: Int, title: String?, genresIds: [Int], releaseDate: Date, imagePath: String?, voteAverage: Int, overview: String?) {
        self.init()
        
        self.id = id
        self.title = title
        // Genres ids from Int to List<Int>
        self.genresIds.append(objectsIn: genresIds.map({ (intValue) -> IntObject in
            return IntObject(withInt: intValue)
        }))
        self.releaseDate = releaseDate
        self.imagePath = imagePath
        self.voteAverage = voteAverage
        self.overview = overview
    }
    
    // MARK: - Save the movies
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}

// MARK: - Realm Int wrapping
class IntObject: Object {
    
    dynamic var genreId = 0
    convenience init(withInt intValue: Int) {
        self.init()
        genreId = intValue
    }
}

// MARK: - Decodable extension
extension Movie: Decodable, OperaDecodable {
        
    static func decode(_ data: Any) throws -> Movie {
        return try Movie(id: data => "id",
                        title: data => "title",
                        genresIds: data => "genre_ids",
                        releaseDate: data => "release_date",
                        imagePath: data =>? "poster_path",
                        voteAverage: data => "vote_average",
                        overview: data =>? "overview")
    }

}
