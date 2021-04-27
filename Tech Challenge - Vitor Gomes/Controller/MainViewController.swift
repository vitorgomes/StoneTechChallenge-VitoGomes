//
//  MainViewController.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var cvFacts: UICollectionView!
    @IBOutlet weak var sbSearchFacts: UISearchBar!
    @IBOutlet weak var nbMainScreen: UINavigationBar!
    
    var factsManager = FactsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvFacts.dataSource = self
        
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        sbSearchFacts.isHidden = false
    
        
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
        
//        let value = factsManager.searchCategory(category: <#T##String?#>)
//        
//        cell.setup(with: factsManager.)
        
        return cell
    }
}
