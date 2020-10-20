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
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var viewModel = ViewModel(networkManager: URLSession.shared)
    
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
     
    
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        itemTableView.layer.borderWidth = 2.0
        itemTableView.layer.cornerRadius = 10
        itemTableView.alpha = 0
        
        
        itemTableView.reloadData()
        itemTableView.layoutIfNeeded()
        heightConstraint.constant = itemTableView.contentSize.height
        
        cartButton.layer.cornerRadius = 10
        cartButton.clipsToBounds = true
        
        
        
        
        
        
        
        
    
        
    }

}


extension CartView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            
            let count = Singleton.shared.getCart().count
            
            return count
   
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

       
            
            if let cell = itemTableView.dequeueReusableCell(withIdentifier: "CartTableVC") as? CartTableViewCell{
                let cart = Singleton.shared.getCart()
                if cart.count > 0{
                    let cartData = Singleton.shared.getCart()[indexPath.row]
                    let category = viewModel.getCategoryWithId(categoryId: cartData.itemId)
                    return cell.feedData(product: cartData, category: category)
                }
                else{
                    return cell
                }
                
            }
            return UITableViewCell()
        
        
        
    }
    

    
    
    
    
}

