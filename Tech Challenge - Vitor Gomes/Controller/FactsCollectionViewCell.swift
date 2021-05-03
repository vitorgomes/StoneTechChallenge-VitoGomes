//
//  FactsCollectionViewCell.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class FactsCollectionViewCell: UICollectionViewCell {

//    var heightSize: CGFloat?
    
    @IBOutlet weak var lbFactsText: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    
    func setup(with facts: FactsData?, index: Int) {
        
        let result = facts!.result[index]
        
        lbFactsText.text = result.value
        print(result.value)
        if let category = result.categories.first {
            
            lbCategories.text = category!.uppercased()
            lbCategories.sizeToFit()
//            heightSize = lbFactsText.frame.height + lbCategories.frame.height
        } else {
            
            lbCategories.text = "UNCATEGORIZED"
            lbCategories.sizeToFit()
//            heightSize = lbFactsText.frame.height + lbCategories.frame.height
        }
        
//        return heightSize!
    }
    
    func heightSum (factTextHeight: CGFloat, categoriesHeight: CGFloat) -> CGFloat {
        
        var heightSum: CGFloat
        heightSum = lbFactsText.frame.height + lbCategories.frame.height
        
        return heightSum
    }
    
    @IBAction func btShare(_ sender: UIButton) {
        
//        func copyURL(with facts: FactsData?, index: Int) {
//
//            let result = facts!.result[index]
//            UIPasteboard.general.string = result.url
//        }
    }
}
