//
//  Zeplin.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/3/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Foundation
import UIKit

// Color palette
extension UIColor {
    
    class var mitBlack: UIColor {
        return UIColor(white: 33.0 / 255.0, alpha: 1.0)
    }
    
    class var mitWarmGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    
    class var mitBrownishGrey: UIColor {
        return UIColor(white: 110.0 / 255.0, alpha: 1.0)
    }
    
    class var mitCoral: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 78.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
    }
    
}

// Sample text styles

extension UIFont {
    
    class func latoRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Lato-Bold", size: size)
    }
    
    class func kavoonRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Kavoon-Regular", size: size)
    }
    
}
