//
//  FactsCollectionViewCell.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class FactsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvFactText: UITextView!
    @IBOutlet weak var tfCategories: UITextField!
    
    func setup(with facts: FactsData?, index: Int){
        
        let result = facts!.result[index]
        
//        tvFactText.text = result.value
        print(result.value)
        if let category = result.categories.first {
            tfCategories.text = category
        }
    }
    
    @IBAction func btShare(_ sender: UIButton) {
    }
}
