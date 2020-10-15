//
//  ViewController.swift
//  Example
//
//  Created by Manish Meher Edida on 08/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var cartButton: UIButton!
    
    @IBOutlet weak var cartTableHeight: NSLayoutConstraint!
    
    
    var viewModel:ViewModel!
    
    var cartOpen = false
 
    
    
    class func initViewController()->ViewController{
      
        let viewController =  ViewController(nibName: "ViewController", bundle: nil)
        viewController.viewModel = ViewModel(networkManager: URLSession.shared)
        return viewController
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
        
        cartTableHeight.constant = 0
        
        cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableVC")
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        
        cartTableView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        cartTableView.layer.borderWidth = 2.0
        //cartTableView.estimatedRowHeight = 42
        //cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.layer.cornerRadius = 10
        
        
        cartButton.layer.cornerRadius = 10
        cartButton.clipsToBounds = true
        
        
        

        do{
            try viewModel.downloadJson(completion: { [weak self] (succes) in
                if succes{
                    self?.tableView.reloadData()
                    
                }
                else{
                    //handle error
                    print("Error")
                }
            })
        }
        catch( let error ) {
            print(error)
            
        }
    }
    
    
    // escaping closure
    @IBAction func cartButton(_ sender: Any) {
        if cartOpen{
            cartTableView.alpha = 0
            cartOpen = false
            
        }
        else{
            
            cartTableView.reloadData()
            cartTableView.layoutIfNeeded()
            cartTableHeight.constant = cartTableView.contentSize.height
           // cartTableView.heightAnchor.constraint( equalToConstant: cartTableView.contentSize.height).isActive = true
            cartTableView.alpha = 1
            cartOpen = true
        }
    }
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView
        {
            let count = viewModel.getCountOfGroceries()
            
            return count
        }
        else{
            
            
            let count = Singleton.shared.getCart().count
            
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell{
                
                
                let cellData = viewModel.getCellData(indexPath: indexPath)
                
                //call object
                return cell.feedData(category: cellData)
            }
            return UITableViewCell()
        }
        else{
            
            if let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTableVC") as? CartTableViewCell{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            cartTableView.alpha = 0
            cartOpen = false
            let secondVC = SecondViewController.initViewController()
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    
    
    
    
}

