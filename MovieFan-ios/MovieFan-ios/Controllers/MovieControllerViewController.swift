//
//  MovieControllerViewController.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/1/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit
import RxSwift
import Opera

class MovieControllerViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    // MARK: Outlets
    @IBOutlet weak var seeMoviesButton: UIButton!
    
    // MARK: Actions
    @IBAction func seeMoviesTapped(_ sender: UIButton) {
        TheMovieDbAPI.Movies.Discover()
            .rx_collection("results")
            .subscribe(onNext: { (movies: [Movie]) in
                print(movies)
            }, onError: { error in
                print(error)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func selectedFilters(genre: Int, year: Date, adultContent: Bool) {
        
    }
    
}
