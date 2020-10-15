//
//  CartTableViewCell.swift
//  Example
//
//  Created by Manish Meher Edida on 15/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    var viewModel = ViewModel(networkManager: URLSession.shared)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func feedData(product:Product, category:Category?)->CartTableViewCell{
        //itemId.text = String(product.itemId)
        quantity.text = "Quatity: \(String(product.itemCount))"
        guard let category = category else{
            print("Failed to find")
            return self
        }
        itemId.text = category.label
        return self
    }
    
}
