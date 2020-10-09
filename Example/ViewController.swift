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
    
    var categories = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
        downloadJson {
            self.tableView.reloadData()
        }
        
    }
    
    func downloadJson(completed: @escaping () ->()){
        
        if let categoryURL = URL(string: ApiURLs.categoriesURL){
            let session = URLSession.shared
            let task = session.dataTask(with: categoryURL) { (data, response, error) in
                if let data = data, error == nil{
                    let decoder = JSONDecoder()
                    do{
                        
                        self.categories = try decoder.decode(Categories.self, from: data)
                        
                        print("categories loaded succesfully")
                        DispatchQueue.main.async {
                            completed()
                        }
                
                    }
                    catch{
                        print("Error")
                    }
                }
            }
         task.resume()
        }

    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = categories.groceries?.count{
            print(count)
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell{
            
            if categories.groceries != nil{
                if categories.groceries!.indices.contains(indexPath.row){
                    
                    return cell.feedData(label: categories.groceries![indexPath.row].label, imageURL: categories.groceries![indexPath.row].imageURL)
                }
                
            }
        }
        
        
        return UITableViewCell()
    }
    
    
}

