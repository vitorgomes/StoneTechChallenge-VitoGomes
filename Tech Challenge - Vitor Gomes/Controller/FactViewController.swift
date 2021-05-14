//
//  FactViewController.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import UIKit

// Controller thats control second screen where presents the selected fact
class FactViewController: UIViewController {

    // Variables to store the text and URL from the first screen
    var receivedValue: String = ""
    var receivedURL: String = ""
    
    @IBOutlet weak var lbFactValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedValue)
        print(receivedURL)
        lbFactValue.text = receivedValue
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        /* Pasting the URL to the clipboard.
         If you want to test:
         1) Please click on the back button "<",
         2) then click on search icon like you would search for a new word,
         3) then click on the search bar,
         4) wait until the "paste" or "colar" ballon appears, then click on it.
         
         You will see the URL on the search bar. In a production app you could go back where you wanna paste the text and do the same thing :) */
        let pasteboard = UIPasteboard.general
        pasteboard.string = receivedURL
        print(receivedURL)
    }
}
