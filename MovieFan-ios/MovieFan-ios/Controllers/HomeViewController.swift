//
//  HomeViewController.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/8/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Opera
import RealmSwift
import RxSwift
import UIKit
import XLSwiftKit

class HomeViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorConnectionView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortMoviesButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Actions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        // Asigne the segue to FilterViewController
        performSegue(withIdentifier: R.segue.homeViewController.showFilters, sender: self)
    }
    
    // MARK: - Variables
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    var movies: Results<Movie> {
        return self.realm.objects(Movie.self)
    }
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Movie cell equal to the movieCell xib
        tableView.register(R.nib.movieCell)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the movies once that the genders are loaded
        GenreManager.instance.getGenres(completionHandler: { (success) -> Void in
            if success {
                self.getMovies(parameters: [String: Any]())
            }
        })
    }
    
    // MARK: - View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.backgroundColor = .mitBlack
    }
    
    // MARK: - Get movies
    func getMovies(parameters: [String : Any]) {
        LoadingIndicator.show()
        
        TheMovieDbAPI.Movies.Discover(parameters: parameters)
            .rx_collection("results")
            .subscribe(onNext: { [unowned self] (movies: [Movie]) in
                try! self.realm.write {
                    //Delete movies stored
                    let allMovies = self.realm.objects(Movie.self)
                    self.realm.delete(allMovies)
                    // Add movies
                    self.realm.add(movies)
                    self.tableView.reloadData()
                    self.errorConnectionView.isHidden = true
                    
                    LoadingIndicator.hide()
                }
            }, onError: { error in
                LoadingIndicator.hide()
                // Show the error connection message
                self.errorConnectionView.isHidden = false
                print(error)
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Delegate to FiltersViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let filterViewController = segue.destination as? FiltersViewController else { return }
        filterViewController.delegate = self
    }

}

// MARK: - Datasource extension
extension HomeViewController: UITableViewDataSource {
    
    // MARK: - TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath) ?? MovieTableViewCell()
        let movie = movies[indexPath.row]
        cell.configuration(with: movie)
        
        cell.backgroundColor = .mitWhite
        return cell
    }

}

// MARK: - Update the parameters with the selected filter values
extension HomeViewController: FilterMoviesProtocol {
    
    func didSelectFilters(selectedValues: [String : Any]) {
        getMovies(parameters: selectedValues)
    }
    
}
