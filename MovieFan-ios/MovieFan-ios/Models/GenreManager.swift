//
//  GenreManager.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/14/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Decodable
import Foundation
import Opera
import RealmSwift
import RxSwift

class GenreManager {
    
    let disposeBag = DisposeBag()
    // Get the default Realm
    let realm = try! Realm()
    
    // New array to add the data
    var genresList = [Genre]()
    
    // Singleton init
    private init() { }
    
    // Shared Instance
    static let instance: GenreManager = GenreManager()
    
    // Completion handler
    typealias CompletionHandler = (_ success: Bool) -> Void

    // MARK: - Get genres
    func getGenres(completionHandler: @escaping CompletionHandler) {
        TheMovieDbAPI.Movies.Genre()
            .rx_collection("genres")
            .subscribe(onNext: { [unowned self] (genres: [Genre]) in
                self.genresList.append(contentsOf: genres)
                let genresLoaded = true
                completionHandler(genresLoaded)
            }, onError: { error in
                print(error)
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Get the genre's name from genre's Id
    func valueFromGenreId(genreId: Int) -> String {
        var value: String = ""
        if genresList.count > 0 {
            genresList.forEach { genre in
                if genre.id == genreId {
                    value = genre.genderName!
                }
            }
        }
        return value
    }
    
    // MARK: - Get the id from genre's name
    func idFromGenreName(genreName: String) -> Int {
        var id: Int = 0
        if genresList.count > 0 {
            genresList.forEach { genre in
                if genre.genderName == genreName {
                    id = genre.id
                }
            }
        }
        return id
    }
    
}
