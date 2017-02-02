//
//  MovieRoute.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/1/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Foundation
import Alamofire
import Opera

struct TheMovieDbAPI {
    
    struct Movies {}
    
}

extension TheMovieDbAPI.Movies {
    
    struct Discover: RouteType {
        
        var method: HTTPMethod { return .get }
        var path: String { return "discover/movie" }
        
    }
       
}
