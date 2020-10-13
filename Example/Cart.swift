//
//  Cart.swift
//  Example
//
//  Created by Manish Meher Edida on 12/10/20.
//  Copyright © 2020 Manish Meher Edida. All rights reserved.
//

import Foundation


class Singleton{
    static let shared = Singleton()
    
    private init(){}
    
    private var cart = [Product]()
    
    private func updateIfIdExists(productId:Int){
        var idExists = false
        cart = cart.map({ (product) -> Product in
            if product.itemId == productId{
                idExists = true
                var modified = product
                modified.itemCount += 1
                return modified
            }
            else{
                return product
            }
        })
        
        if(!idExists){
            cart.append(Product(itemId: productId, itemCount: 1))
        }
    }
    
    
    func addToCart(productId:Int){

        updateIfIdExists(productId: productId)

    }
    
    func getCart()->[Product]{
        return cart
    }
    
    
}



