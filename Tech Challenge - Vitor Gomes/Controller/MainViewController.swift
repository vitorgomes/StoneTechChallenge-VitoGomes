//
//  MainViewController.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var facts: FactsData? // Store all the facts based on the struct created on FactsData
    var factsManager = FactsManager() // Instance of FactsManager to work on this controller
    var numberOfCV = 0

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
    
    // Transferring the fact text to the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMainToFact" {
            
            let vc = segue.destination as! FactViewController
            
            vc.modalPresentationStyle = .fullScreen
            
            // Getting the index of the sellected item to collect the data for next screen
            let indexPath = cvFacts.indexPathsForSelectedItems?.first
            let factResult = facts!.result[indexPath!.row]

            vc.receivedValue = factResult.value
            vc.receivedURL = factResult.url
            
        }
    }
    
}

// SearchBar delegate extension for when tap to search button
extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        sbSearchFacts.isHidden = true
        sbSearchFacts.resignFirstResponder()
        
        if let realFact = sbSearchFacts.text {
            
            // Returning the facts from JSON via closure, declared on FactsManager
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
        // Setting the cell to use FactsCollectionViewCellDelegate protocol created on FactsCollectionViewCell
        cell.delegate = self
        cell.sharedURL = (facts?.result[indexPath.row].url)!

        return cell
    }
    
}

// Extension to configure cell sizes
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var targetSize = UIView.layoutFittingCompressedSize
        targetSize.width = collectionView.frame.width - 40
        
        let cell = cvFacts.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath) as! FactsCollectionViewCell
        cell.setup(with: facts, index: indexPath.row)
        
        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    }
}

// Extension for when you tap the cell
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// Extension to make share button inside FactsCollectionViewCell works (via delegate)
extension MainViewController: FactsCollectionViewCellDelegate {
    
    func btShare(with url: String) {
        
        /* Pasting the URL to the clipboard.
         If you want to test:
         1) Please click on the back button "<",
         2) then click on search icon like you would search for a new word,
         3) then click on the search bar,
         4) wait until the "paste" or "colar" ballon appears, then click on it.
         
         You will see the URL on the search bar. In a production app you could go back where you wanna paste the text and do the same thing :) */
        let pasteboard = UIPasteboard.general
        pasteboard.string = url
        print(url)
    }
}
