//
//  SecondViewController.swift
//  Example
//
//  Created by Manish Meher Edida on 12/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

 
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartView: CartView!
    
    
    var viewModel:ViewModel!
    
   
    
    class func initViewController()->SecondViewController{
        let viewController = SecondViewController(nibName: "SecondViewController", bundle: nil)
        viewController.viewModel = ViewModel(networkManager: URLSession.shared)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize( width: collectionView., height: 300)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    
        
        do{
            try viewModel.downloadJson(completion: { [weak self] (success) in
                if(success){
                    self?.collectionView.reloadData()
                }
                else{
                    print("Json load failed")
                }
            })
        }
        catch (let error){
            print(error)
        }
        
  
    }

    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, BuyButtonDelegate{

 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountOfGroceries()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell{
            
            cell.delegate = self
            let cellData = viewModel.getCellData(indexPath: indexPath)
            
            cell.buyButtonAction = { (productId) in
                
                Singleton.shared.addToCart(productId: productId)
                print(Singleton.shared.getCart())
                
            }
            
            
            
            
            return cell.feedData(category: cellData)
            
        }
        return UICollectionViewCell()
    }
    
    
    func didTapButton(productId: Int) {
        print("\(productId) button pressed")
        Singleton.shared.addToCart(productId: productId)
        print(Singleton.shared.getCart())
        
    }


    
}

extension SecondViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let padding: CGFloat = 10
        
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: 270)
    }
}

