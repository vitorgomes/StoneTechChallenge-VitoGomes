//
//  FactsCollectionViewCell.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

// Protocol to use on the delegate design pattern. Creating the function where MainViewController will create the function ativity.
protocol FactsCollectionViewCellDelegate: AnyObject {
    
    func btShare(with url: String)
}

class FactsCollectionViewCell: UICollectionViewCell {
    
    // Variables to set the MainViewController delegate of the cell and store the URL string on sharedURL
    weak var delegate: FactsCollectionViewCellDelegate?
    var sharedURL: String = ""
    
    @IBOutlet weak var lbFactsText: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    
    // Setting data inside cell elements
    func setup(with facts: FactsData?, index: Int) {
        
        let result = facts!.result[index]
        
        if result.value.count <= 80 {
            
            lbFactsText.font = lbFactsText.font.withSize(25)
        } else {
            
            lbFactsText.font = lbFactsText.font.withSize(17)
        }
        
        lbFactsText.text = result.value
        print(result.value)
        if let category = result.categories.first {
            
            lbCategories.text = category!.uppercased()
            lbCategories.sizeToFit()
//            lbCategories.intrinsicContentSize.width
        } else {
            
            lbCategories.text = "UNCATEGORIZED"
            lbCategories.sizeToFit()
//            lbCategories.intrinsicContentSize.width
        }
    }
    
    // This button working through delegate design pattern to receive the URL string
    @IBAction func btShare(_ sender: UIButton) {
        
        delegate?.btShare(with: sharedURL)
    }
    
}
