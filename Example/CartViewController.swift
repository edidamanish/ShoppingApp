//
//  CartViewController.swift
//  Example
//
//  Created by Manish Meher Edida on 16/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

protocol  ViewControllerDelegate : AnyObject{
    func didDismissCartVC()
}

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartTableHeight: NSLayoutConstraint!
    
    var viewModel:ViewModel!
    weak var vcDelegate: ViewControllerDelegate?
    
    class func initViewController()->CartViewController{
      
        let cartViewController =  CartViewController(nibName: "CartViewController", bundle: nil)
        cartViewController.viewModel = ViewModel(networkManager: URLSession.shared)
        
        return cartViewController
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cartButton.layer.cornerRadius = 10
        cartButton.clipsToBounds = true
        
        cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableVC")
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        cartTableView.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        cartTableView.layer.borderWidth = 2.0
        cartTableView.layer.cornerRadius = 10
        
      
        
        
        do{
            try viewModel.downloadJson(completion: { [weak self] (succes) in
                if succes{
                    self?.cartTableView.reloadData()
                    self?.cartTableView.layoutIfNeeded()
                    self?.cartTableHeight.constant = self?.cartTableView.contentSize.height ?? 0
                    
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
        

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapCart(_ sender: Any) {
        
        vcDelegate?.didDismissCartVC()
        self.dismiss(animated: false, completion: nil)
        
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            
            let count = Singleton.shared.getCart().count
            
            return count
   
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

       
            
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
