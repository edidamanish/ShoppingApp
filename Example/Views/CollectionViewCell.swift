//
//  CollectionViewCell.swift
//  Example
//
//  Created by Manish Meher Edida on 12/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit


protocol BuyButtonDelegate: AnyObject {
    func didTapButton(productId:Int)
}


final class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    private var categoryId:Int?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.buyButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    
    //Delegate Methods
    
    weak var delegate:BuyButtonDelegate?
    
    
    var buyButtonAction:((Int)->())?
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        
 
        guard let id = categoryId else {
            return
        }
        buyButtonAction?(id)
        
        //delegate?.didTapButton(productId: id)
        
    }
    
    //Completion Closure
    

    
    
    
    
    func feedData(category:Category?)-> CollectionViewCell{
        if let id = category?.id{
            categoryId = id
        }
        
        if let label = category?.label {
            print("Label found \(label)")
            categoryLabel.text = label
        }
        
        if let urlString = category?.imageURL{
            if let url = URL(string: urlString){
                print("Got Url")
                loadImage(imageUrl: url)
            }
        }
        
    
        return self
    }
    
    
    private func loadImage(imageUrl:URL){
        let session = URLSession.shared
        let task = session.dataTask(with: imageUrl) { (data, response, error) in
            if let data = data{
                DispatchQueue.main.async {
                    print("URL hit success")
                    self.categoryImage.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
    

}
