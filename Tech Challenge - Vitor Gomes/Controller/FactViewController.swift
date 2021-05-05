//
//  FactViewController.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

class FactViewController: UIViewController {

    var receivedValue: String = ""
    
    @IBOutlet weak var lbFactValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedValue)
        lbFactValue.text = receivedValue
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        // Under construction
    }
}
