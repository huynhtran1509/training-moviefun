//
//  FilterButtonsCell.swift
//  MovieFan-ios
//
//  Created by KFernandez on 2/3/17.
//  Copyright © 2017 'Xmartlabs SRL'. All rights reserved.
//

import Foundation
import Eureka

// MARK: - Protocol
protocol ApplyFiltersProtocol: class {
    
    func applyFilters()
    func cancelTap()
    
}

public class FilterButtonsCell: Cell<String>, CellType {

    // MARK: - Variables
    weak var delegate: ApplyFiltersProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            textLabel?.textColor = .mitBrownishGrey
        }
    }
    
    @IBOutlet weak var applyButton: UIButton! {
        didSet {
            applyButton.layer.cornerRadius = 24
            applyButton.backgroundColor = .mitCoral
        }
    }
    
    // MARK: - Actions
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        delegate?.cancelTap()
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        delegate?.applyFilters()
    }
    
    // MARK: - Setup button section
    open override func setup() {
        super.setup()
        
        height = { 100 }
        selectionStyle = .none
    }

}

public final class FilterButtonRow: Row<FilterButtonsCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        
        cellProvider = CellProvider<FilterButtonsCell>(nibName: "FilterButtonsCell")
    }

}
