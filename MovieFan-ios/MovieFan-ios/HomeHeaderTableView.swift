//
//  HeaderHomeUITableViewHeaderFooterView.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/8/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol FilterButtonTapped: class {
    func filterButtonTap()
}

class HomeHeaderTableView: UIView {

    // MARK: - Variables
    weak var delegate: FilterButtonTapped?
    
    // MARK: - Outlets
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
   
    // MARK: - Actions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
            delegate?.filterButtonTap()
    }
}
