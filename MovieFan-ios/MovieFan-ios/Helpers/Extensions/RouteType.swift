//
//  RouteType.swift
//  MovieFan-ios
//
//  Created by Xmartlabs SRL ( https://xmartlabs.com )
//  Copyright © 2016 Xmartlabs SRL. All rights reserved.
//

import Foundation
import Opera
import Alamofire

extension RouteType {

    var baseURL: URL { return Constants.Network.baseUrl }
    var manager: ManagerType { return NetworkManager.singleton  }
    var retryCount: Int { return 0 }
}

extension URLRequestSetup {

    func urlRequestSetup(_ urlRequest: NSMutableURLRequest) {
        // setup url
    }
}
