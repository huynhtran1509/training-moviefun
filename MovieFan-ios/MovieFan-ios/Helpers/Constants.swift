//
//  Constants.swift
//  MovieFan-ios
//
//  Created by Xmartlabs SRL ( https://xmartlabs.com )
//  Copyright (c) 2016 Xmartlabs SRL. All rights reserved.
//

import Foundation
import Opera
import XLSwiftKit

struct Constants {

	struct Network {
        static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
        static let AuthTokenName = "Authorization"
        static let ApiKey = "31eb416f5a4beac0a44a19daf3c26823"
        static let SuccessCode = 200
        static let successRange = 200..<300
        static let Unauthorized = 401
        static let NotFoundCode = 404
        static let ServerError = 500
    }

    struct Keychain {
        static let serviceIdentifier = UIApplication.bundleIdentifier
    }
    
    struct Formatters {
        
        static let debugConsoleDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            formatter.timeZone = TimeZone(identifier: "UTC")!
            return formatter
        }()
        
        static let MovieDbAPIDateFormatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd"
            return f
        }()
        
    }
    
    struct Debug {
        static let crashlytics = false
        static let jsonResponse = false
    }
}
