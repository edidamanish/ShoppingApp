//
//  ViewModel.swift
//  Example
//
//  Created by Manish Meher Edida on 09/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

final class ViewModel{
    
    private(set) var categories = Categories()
    
    private var networkManager:URLSession
    
    init(networkManager:URLSession) {
        self.networkManager = networkManager
    }
    
    func downloadJson(completion: @escaping ((Bool)->())) throws {
        guard let categoryURL = URL(string: ApiURLs.categoriesURL) else {
            throw NSError(domain: "URL nil", code: 100, userInfo: nil)
            
        }
        
        
        let session = networkManager
        let task = session.dataTask(with: categoryURL) { [weak self] (data, response, error) in
            if let data = data, error == nil{
                let decoder = JSONDecoder()
                do{
                    
                    self?.categories = try decoder.decode(Categories.self, from: data)
                    
                    print("categories loaded succesfully")
                    DispatchQueue.main.async {
                        completion(true)
                        
                    }
                    
                }
                catch{
                    completion(false)
                    print("Error")
                }
            }
            else{
                completion(false)
                    //throw NSError(domain: "Did not get data", code: 102, userInfo: nil)
            }
        }
        task.resume()
        
        
    }
    
    func getCountOfGroceries()->Int{
        return self.categories.groceries?.count ?? 0
    }
    
    func getCellData(indexPath:IndexPath)->(Category?){
        guard let groceries = categories.groceries else{
            return nil
        }
        return (groceries[indexPath.row])
        
    }
    

}
