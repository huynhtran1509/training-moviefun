//
//  MovieRoute.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/1/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit
import Opera
import Alamofire

struct TheMovieDbAPI {
    
    struct Movies {}
    
}

extension TheMovieDbAPI.Movies {
    
    // MARK: - Movie routeType
    struct Discover: RouteType {
        
        var method: HTTPMethod { return .get }
        var path: String { return "discover/movie" }
        var parameters: [String : Any]?
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
            self.parameters?["api_key"] = Constants.Network.ApiKey
        }
        
    }
    
    // MARK: - Genre routeType
    struct Genre: RouteType {
        
        var method: HTTPMethod { return .get }
        var path: String { return "genre/movie/list" }
        var parameters: [String : Any]? = ["api_key": Constants.Network.ApiKey]
        
    }
    
}
