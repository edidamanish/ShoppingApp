//
//  CartView.swift
//  Example
//
//  Created by Manish Meher Edida on 15/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

class CartView: UIView {

    @IBOutlet var cartView: UIView!
    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("CartView", owner: self, options: nil)
        addSubview(cartView)
        
        
        cartView.frame = self.bounds
        cartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     
    
        
        itemTableView.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        itemTableView.layer.borderWidth = 2.0
        itemTableView.layer.cornerRadius = 10
        itemTableView.alpha = 0
        
        cartButton.layer.cornerRadius = 10
        cartButton.clipsToBounds = true
        
        
        
        
        
        
        
        
    
        
    }

}
