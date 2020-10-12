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
    
    
    var viewModel:ViewModel!
    
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
    
    
}

