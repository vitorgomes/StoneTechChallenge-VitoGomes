//
//  MainViewController.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var facts: FactsData?
    var factsManager = FactsManager()
    var numberOfCV = 0

    @IBOutlet weak var cvFacts: UICollectionView!
    @IBOutlet weak var sbSearchFacts: UISearchBar!
    @IBOutlet weak var nbMainScreen: UINavigationBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvFacts.dataSource = self
        sbSearchFacts.isHidden = true
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        sbSearchFacts.resignFirstResponder()
        sbSearchFacts.isHidden = !sbSearchFacts.isHidden
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCV
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
        
//        let fact = facts?.result[indexPath.row]
//
//        if let category = fact?.categories.first {
//            cell.tfCategories.text = category
//        }
        
        cell.setup(with: facts, index: indexPath.row)
        
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        sbSearchFacts.isHidden = true
        sbSearchFacts.resignFirstResponder()
        
        if let realFact = sbSearchFacts.text {
            
            factsManager.factsRequest(realFact) { (facts) in
                
                self.facts = facts
                self.numberOfCV = self.facts!.total
                DispatchQueue.main.async {
                    self.cvFacts.reloadData()
                }
            } onError: { (error) in
                
                print(error)
            }

        }
        
        
    }
}
