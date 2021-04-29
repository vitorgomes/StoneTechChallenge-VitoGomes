//
//  FactsManager.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 26/04/21.
//

import Foundation

//List of possible errors for the escaping closure onError
enum FactError {
    
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class FactsManager {
    
    func factsRequest(_ fact: String?, onComplete: @escaping (FactsData) -> Void, onError: @escaping (FactError) -> Void) {
        
        if let unwrappedFact = fact {
            
            let urlString = "https://api.chucknorris.io/jokes/search?query=\(unwrappedFact)"
            guard let url = URL(string: urlString) else {
                
                onError(.url)
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) { ( data, response, error) in
                
                if error == nil {
                    
                    guard let response = response as? HTTPURLResponse else {
                        
                        onError(.noResponse)
                        return
                    }
                    if response.statusCode == 200 {
                        
                        let decoder = JSONDecoder()
                        
                        if let safeData = data {
                            
                            do {
                                
                                let results = try decoder.decode(FactsData.self, from: safeData)
                                
                                onComplete(results)
                            } catch {
                                
                                print(error.localizedDescription)
                                onError(.invalidJSON)
                            }
                        }
                    } else {
                        
                        onError(.responseStatusCode(code: response.statusCode))
                    }
                } else {
                    
                    onError(.taskError(error: error!))
                }
            
            }
    
            task.resume()
        }
    }
}
