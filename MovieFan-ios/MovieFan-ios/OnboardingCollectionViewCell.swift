//
//  OnboardingCollectionViewCell.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/7/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol OnboardingButtonTapped: class {
    
    func onboardingButtonDidTap()
    
}

// MARK: - OnboardingCollectionViewCell class
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    weak var delegate: OnboardingButtonTapped?
    
    // MARK: - Outlets
    @IBOutlet weak var principalLabel: UILabel! {
        didSet {
            principalLabel.font = UIFont.kavoonRegular(26)
        }
    }

    @IBOutlet weak var secondaryLabel: UILabel! {
        didSet {
            secondaryLabel.font = UIFont.latoRegular(14)
        }
    }

    @IBOutlet weak var onboardingImage: UIImageView!
    
    @IBOutlet weak var letsgoButton: UIButton! {
        didSet {
            letsgoButton.layer.cornerRadius = 25
        }
    }
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.onboardingButtonDidTap()
    }
    
}
