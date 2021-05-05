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

        let width = view.frame.size.width

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactsCollectionViewCell", for: indexPath)
//
//        let height = cell.contentView.systemLayoutSizeFitting(cvFacts.contentSize)
        
//        var targetSize = UIView.layoutFittingCompressedSize
//        targetSize.width = collectionView.frame.width
        
//        let result = facts?.result[indexPath.row]
//        let factsValue = result!.value
        
//        let cell = FactsCollectionViewCell.SizingCell
//        cell.setup(with: facts, index: indexPath.row)
//
//        return cell.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)

        
//        cell.contentView.layoutIfNeeded()
//        let height = cell.contentView.systemLayoutSizeFitting(cvFacts.contentSize)

//        let height = cell.contentView.layoutIfNeeded()
//        return CGSize(width: 380, height: 200)
//        return CGSize(width: view.bounds, height: cvFacts.frame.height)

//        let fact = self.cvFacts.dataSource?.collectionView(<#T##collectionView: UICollectionView##UICollectionView#>, cellForItemAt: <#T##IndexPath#>)

//        return CGSize(width: width - 40, height: cvFacts.frame.height) // height esta errado
//        return CGSize(width: width - 40, height: view.frame.size.height / 5)
        
        
        /* Width is working perfectly but problem in on Height.
         I spent days searching for ways to adapt here to my reality searching on famous developers sites, asking on StackOverFlow, CocoaHeads Slack, Reddit, Youtube,
         Apple documentation but i was not able to find a solution to adapt here, or at least, understand the suggestion of people.
         If you look above this method sizeForItemAt these are the only "crap" comments i will left to show things i tried. Note that, suggestions that i used too work with
         these comments are deleted now (those from other files that in teory would work with that commented ways).
         So i decided to left a static value 200 and keep searching for a solution.
         */
        return CGSize(width: width - 40, height: 200)
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

