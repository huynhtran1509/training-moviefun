//
//  UIImageView.swift
//  MovieFan-ios
//
//  Created by Xmartlabs SRL ( https://xmartlabs.com )
//  Copyright © 2016 'Xmartlabs SRL'. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    public func setImageWithURL(_ url: String, filter: ImageFilter? = nil, placeholder: UIImage? = nil, completion: ((DataResponse<UIImage>) -> Void)? = nil) {
        af_setImage(withURL: URL(string: url)!, placeholderImage: placeholder, filter: filter, imageTransition: .crossDissolve(0.3), completion: { (response: DataResponse<UIImage>) in
            if let error = response.result.error {
                print(error.localizedDescription)
            }
            completion?(response)
        })
    }
}
