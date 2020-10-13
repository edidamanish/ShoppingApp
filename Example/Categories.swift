//
//  Categories.swift
//  Example
//
//  Created by Manish Meher Edida on 08/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import Foundation


struct Categories:Codable{
    
    
    var groceries:[Category]?
    
    enum CodingKeys: String, CodingKey{
        case groceries = "items"
    }
 
    
}
