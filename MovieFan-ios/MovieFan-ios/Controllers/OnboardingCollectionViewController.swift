//
//  OnboardingCollectionViewController.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/6/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit

class OnboardingCollectionViewController: UIViewController, UICollectionViewDelegate {

    // MARK: - Struct boarding
    struct Boarding {
        
        var onboardingImage: UIImage
        var principalText: String
        var secondaryText: String
        
    }
    
    // MARK: - Variables
    var boardings: [Boarding] = []
    let principalTextBoarding1 = "For movie lovers"
    let secondTextBoarding1 = "View what’s in theaters, trending movies and much more."
    
    let principalTextBoarding2 = "Indiana would use it"
    let secondTextBoarding2 = "It’s just so sleek and smooth. MovieFan is for you, the fan of movies."
    
    let principalTextBoarding3 = "Ready?"
    let secondTextBoarding3 = "The onboarding is finished, you are now ready to enjoy movies like never before."
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    // MARK: - Add data to the boardings
    func setData() {
        collectionView.register(R.nib.onboardingCell)
        boardings.append(Boarding(onboardingImage: R.image.onboarding1()!, principalText: principalTextBoarding1, secondaryText: secondTextBoarding1))
        boardings.append(Boarding(onboardingImage: R.image.onboarding2()!, principalText: principalTextBoarding2, secondaryText: secondTextBoarding2))
        boardings.append(Boarding(onboardingImage: R.image.onboarding3()!, principalText: principalTextBoarding3, secondaryText: secondTextBoarding3))
    }

    // MARK: - Scroll onboarding
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collection = collectionView else { return }
        let page = Int(collection.contentOffset.x / collection.bounds.width)
        pageControl.currentPage = page
    }

}

// MARK: - Datasource extension
extension OnboardingCollectionViewController: UICollectionViewDataSource {
   
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.onboardingCell, for: indexPath) ?? OnboardingCollectionViewCell()
        cell.letsgoButton.isHidden = true
        cell.onboardingImage.image = boardings[indexPath.item].onboardingImage
        cell.principalLabel.text = boardings[indexPath.item].principalText
        cell.secondaryLabel.text = boardings[indexPath.item].secondaryText
        if indexPath.row == 2 {
            cell.letsgoButton.isHidden = false
            cell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardings.count
    }

}

// MARK: - Present HomeController
extension OnboardingCollectionViewController: OnboardingButtonTapped {
    
    func onboardingButtonDidTap() {
        if let homeVC = R.storyboard.main.homeController() {
            present(homeVC, animated: true)
        }
    }
    
}
