//
//  FactsCollectionViewCell.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class FactsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbFactsText: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    
    // Setting data inside cell elements
    func setup(with facts: FactsData?, index: Int) {
        
        let result = facts!.result[index]
        
        lbFactsText.text = result.value
        print(result.value)
        if let category = result.categories.first {
            
            lbCategories.text = category!.uppercased()
            lbCategories.sizeToFit()
        } else {
            
            lbCategories.text = "UNCATEGORIZED"
            lbCategories.sizeToFit()
        }
    }
    
    @IBAction func btShare(_ sender: UIButton) {
        
        // Under construction
    }
}
