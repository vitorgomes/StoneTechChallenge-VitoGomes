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
    var index: Int = 0
    var height: CGFloat? //-----
    var resultValue: String = ""

    @IBOutlet weak var cvFacts: UICollectionView!
    @IBOutlet weak var sbSearchFacts: UISearchBar!
    @IBOutlet weak var nbMainScreen: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvFacts.dataSource = self
        cvFacts.delegate = self
        cvFacts.collectionViewLayout = UICollectionViewFlowLayout()
        
        sbSearchFacts.isHidden = true
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        
        sbSearchFacts.resignFirstResponder()
        sbSearchFacts.isHidden = !sbSearchFacts.isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMainToFact" {
            
            let vc = segue.destination as! FactViewController
//            DispatchQueue.main.async {
//                vc.lbFactValue.text = self.resultValue
//                self.cvFacts.reloadData()
//            }
            vc.receivedValue = resultValue
            
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCV
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
    
        cell.setup(with: facts, index: indexPath.row)
        
        //Global variables from MainViewController
        index = indexPath.row
//        height = cell.heightSum(factTextHeight: cell.lbFactsText.frame.height, categoriesHeight: cell.lbCategories.frame.height)

        return cell
    }
    
}

// SearchBar delegate extension for when tap to search button
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

// Extension to configure cell sizes
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	
        let width = view.frame.size.width
//        return CGSize(width: 380, height: 200)
//        return CGSize(width: view.bounds, height: cvFacts.frame.height)

        return CGSize(width: width - 40, height: cvFacts.frame.height) // height esta errado
    }
}

// Extension for when you tap the cell
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let result = facts?.result[index]
        resultValue = result!.value

    }
}
