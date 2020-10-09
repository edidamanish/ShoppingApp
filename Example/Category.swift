//
//  Category.swift
//  Example
//
//  Created by Manish Meher Edida on 09/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import Foundation




struct Category: Codable{
    
    var id:Int?
    var label:String?
    var imageURL:String?
    var totatItems:Int?
    
    enum CodingKeys:String, CodingKey{
        case id, label = "title" , imageURL = "imageUrl", totatItems
    }

}

