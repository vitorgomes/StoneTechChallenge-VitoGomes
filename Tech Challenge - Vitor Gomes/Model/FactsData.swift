//
//  FactsData.swift
//  Tech Challenge - Vitor Gomes
//
//  Created by Vitor Gomes on 21/04/21.
//

import Foundation

// Struct for the received JSON format
struct FactsData: Codable {
    
    var total: Int = 0
    var result: [Result]
    
}

// Another struct for the rest of above struct. It is necessary to separate it for better understanding
struct Result: Codable {

    var categories: [String?]
    var created_at: String = ""
    var icon_url: String = ""
    var id: String = ""
    var updated_at: String = ""
    var url: String = ""
    var value: String = ""
    
}
