//
//  ViewController.swift
//  Example
//
//  Created by Manish Meher Edida on 08/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit




final class ViewController: UIViewController , ViewControllerDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var cartButton: UIButton!
    
    
    
    
    var viewModel:ViewModel!
    
    var cartOpen = false
    
    var cartVC:CartViewController!
    
    
    
    
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
        
        
        
        
        cartVC = CartViewController.initViewController()
        cartVC.vcDelegate = self
        cartVC.modalPresentationStyle = .overCurrentContext
        self.view.isOpaque = false
        self.view.alpha = 0.5
        
        
        present(cartVC, animated: false, completion: nil)
        
        
        
    }
    
    
    func didDismissCartVC() {
        print("Did do something")
        self.view.isOpaque = true
        self.view.alpha = 1
        
    }
    
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = viewModel.getCountOfGroceries()
        
        return count
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell{
            
            
            let cellData = viewModel.getCellData(indexPath: indexPath)
            
            //call object
            return cell.feedData(category: cellData)
        }
        return UITableViewCell()
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //cartTableView.alpha = 0
        cartOpen = false
        let secondVC = SecondViewController.initViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
    
    
    
}






