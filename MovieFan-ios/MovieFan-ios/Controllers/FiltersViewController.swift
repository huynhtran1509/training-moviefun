//
//  FiltersViewController.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/3/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import UIKit
import Eureka

class FiltersViewController: FormViewController {
    
    let genre = [Int]()

    // MARK: - Action to close the modal view
    @IBAction func dimiss(_ sender: Any) {
    }
    
    // MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        form
            +++ Section(header: "Filter results", footer: "") { section in
                var header = HeaderFooterView<UIView>(.nibFile(name: R.nib.headerFilterView.name, bundle: R.nib.headerFilterView.bundle))
                header.height = { 63 }
                section.header = header
            }
            <<< MultipleSelectorRow<String> {
                $0.title = "Genre"
                $0.options = ["Thriller", "Horror", "Adventure", "Romance", "Science", "Fiction"]
                $0.value = ["Any"]
                $0.cell.height = { 60 }
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
                    date = date.addingTimeInterval(60*60*24*365)
                }
                row.value = row.options[0]
                row.cell.height = { 60 }
            }
            <<< SwitchRow {
                $0.title = "Display adult content"
                $0.value = false
                $0.cell.height = { 60 }
            }
            <<< FilterButtonRow() /* { row in
               row.onClear = {
                    
                }
                
                row.onApply = {
                    
                } */
    }
    
    // MARK: - Clear all values
    func clearAllSelectedValues() {
    }
    
    // MARK: - Add selected values 
    func applySelectedValues() {
        //genre = MultipleSelectorRow.
        //MovieControllerViewController.selectedFilters(genre: Int, year: Date, adultContent: Bool)
    }

}
