//
//  FiltersViewController.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/3/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Eureka
import UIKit

// MARK: - Protocol
protocol FilterMoviesProtocol: class {
    
    func didSelectFilters(selectedValues: [String: Any])
    
}

class FiltersViewController: FormViewController, ApplyFiltersProtocol {
    
    // MARK: - Variables
    weak var delegate: FilterMoviesProtocol?
    
    var selectedValues = [String: Any]()

    // MARK: - Outlets
    @IBOutlet weak var blurView: UIView!
    
    // MARK: - Close the modal view
    @IBAction func dismissViewController(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
        +++ Section(header: "Filter results", footer: "") { section in
            var header = HeaderFooterView<UIView>(.nibFile(name: R.nib.headerFilterCell.name, bundle: R.nib.headerFilterCell.bundle))
            header.height = { 63 }
            section.header = header
        }
        <<< PushRow<String>("GenreRow") {
            $0.title = "Genre"
            // Get the existing genders
            var genreList = [String]()
            GenreManager.instance.genresList.forEach { genre in
                genreList.append(genre.genderName!)
            }
            $0.options = genreList
            $0.value = "Any"
            $0.selectorTitle = "Choose a genre"
            $0.cell.height = { 60 }
            $0.presentationMode = .presentModally(
                controllerProvider: ControllerProvider.callback { return SelectorViewController<String> { _ in } },
                onDismiss: { [weak self] _ in
                    self?.dismiss(animated: true, completion: nil)
                }
            )
        }
        <<< PickerInlineRow<Date>("Year") { row in
            row.title = row.tag
            row.displayValueFor = { (rowValue: Date?) in
                return rowValue.map { "\(Calendar.current.component(.year, from: $0))" }
            }
            row.options = []
            var date = Date()
            for _ in 1...10 {
                row.options.append(date)
                date = date.addingTimeInterval(-365*60*60*24)
            }
            row.value = row.options[0]
            row.cell.height = { 60 }
        }
        <<< SwitchRow("AdultContent") {
            $0.title = "Display adult content"
            $0.value = false
            $0.cell.height = { 60 }
        }
        <<< FilterButtonRow {
            $0.cell.delegate = self
        }
    }
    
    // MARK: - Animate the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0.3,
                       animations: {
                        self.blurView.alpha = 0.74
        },
        completion: nil)
    }
    
    // MARK: - Apply the selected filters
    func applyFilters() {
        selectedValues = form.values()
        
        var filterSelected = [String: Any]()
        var year: Int?
        var genreId: Int?
        var adultContent = false
        
        // Get the selected year
        if let date = selectedValues["Year"] as? Date {
            let dateValue = date.year()
            year = Int(dateValue)!
        }
        // Get the id from the selected genre
        if selectedValues["GenreRow"] != nil {
            if let genre = selectedValues["GenreRow"] as? String {
                if genre != "Any" {
                    genreId = GenreManager.instance.idFromGenreName(genreName: genre)
                }
            }
        }
        // Get the value of adult content
        if let adult = selectedValues["AdultContent"] as? Bool {
            adultContent = adult
        }
        
        if year != nil {
            filterSelected["year"] = year
        }
        if genreId != nil {
            filterSelected["with_genres"] = genreId
        }
        filterSelected["include_adult"] = adultContent
        
        // Delegate to home the filters selected
        delegate?.didSelectFilters(selectedValues: filterSelected)
        self.dismiss(animated: true, completion: nil)
        
    }

    // MARK: - Cancel button tap
    func cancelTap() {
        dismiss(animated: true, completion: nil)
    }
    
}
