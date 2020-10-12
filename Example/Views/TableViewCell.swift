//
//  TableViewCell.swift
//  Example
//
//  Created by Manish Meher Edida on 08/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

    override func prepareForReuse() {
        categoryImage.image = nil
        categoryLabel.text = ""
    }

    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func feedData(category:Category?)-> TableViewCell{
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
