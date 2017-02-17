//
//  Genre.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/10/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Decodable
import Foundation
import Opera
import RealmSwift

final class Genre: Object {

    dynamic var id: Int = 0
    dynamic var genderName: String?
    
    // MARK: - Initialization
    convenience init(id: Int, genderName: String?) {
        self.init()
        
        self.id =  id
        self.genderName = genderName
    }
    
    // MARK: - Save the genres
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

// MARK: - Decodable extension
extension Genre: Decodable, OperaDecodable {
        
    static func decode(_ data: Any) throws -> Genre {
        return try Genre(id: data => "id",
                         genderName: data => "name")
    }
    
}
