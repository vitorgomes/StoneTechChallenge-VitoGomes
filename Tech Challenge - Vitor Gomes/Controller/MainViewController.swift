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
        
        // Show and hide searchBar
        sbSearchFacts.resignFirstResponder()
        sbSearchFacts.isHidden = !sbSearchFacts.isHidden
    }
    
    // Transferring the fact text to the next screen. It is working but delayed, still need to fix it.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMainToFact" {
            
            let vc = segue.destination as! FactViewController
            
            vc.modalPresentationStyle = .fullScreen

            vc.receivedValue = resultValue
            
        }
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

extension MainViewController: UICollectionViewDataSource {
    
    // Number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCV
    }
    
    // Creating cell and giving it content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
    
        cell.setup(with: facts, index: indexPath.row)

        return cell
    }
    
}

// Extension to configure cell sizes
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = collectionView.frame.width - 40
        
        let result = facts?.result[indexPath.row]
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
        cell.setup(with: facts, index: indexPath.row)
        
        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    }
}

// Extension for when you tap the cell
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let result = facts?.result[index]
        resultValue = result!.value
    }
}

