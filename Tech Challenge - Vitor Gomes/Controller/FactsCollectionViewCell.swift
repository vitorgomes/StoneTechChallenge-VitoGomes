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
    
    func setup(with facts: FactsData){
    }
    
    @IBAction func btShare(_ sender: UIButton) {
    }
}
