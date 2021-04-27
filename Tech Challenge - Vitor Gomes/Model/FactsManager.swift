//
//  FactsManager.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 26/04/21.
//

import Foundation

struct FactsManager {
    
    func factsRequest(_ fact: String?) {
        
        if let unwrappedFact = fact {
            
            let urlString = "https://api.chucknorris.io/jokes/search?query=\(unwrappedFact)"
            let url = URL(string: urlString)!
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        
                        do {
                            
                            let results = try decoder.decode(FactsData.self, from: safeData)
                        } catch {
                            
                            print(error)
                        }
                    }
                }
            
            }
    
            task.resume()
        }
    }
}
