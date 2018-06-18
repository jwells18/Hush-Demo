//
//  ProductManager.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

class ProductManager: NSObject{
    
    var ref: DatabaseReference!
    
    //TODO: Remove Uploading functions for production version
    func upload(product: Product, image: UIImage?, completionHandler:@escaping (Bool) -> Void) {
        if image != nil {
            //Convert Image to Data
            let imageData = UIImageJPEGRepresentation(image!, 0.7)
            //Save Item Image
            let uuid = UUID().uuidString
            let imageFileName = String(format: "%@.jpeg", uuid)
            let storageRef = Storage.storage().reference()
            _ = storageRef.child(productDatabase).child(product.name).child(imageFileName).putData(imageData!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL: URL = metadata.downloadURL()!
                
                //Upload Product
                self.uploadProduct(product: product, imageURL: downloadURL, completionHandler: { (isCompleted) in
                    completionHandler(isCompleted)
                })
            }
        }
        else{
            //Upload Product
            self.uploadProduct(product: product, imageURL: nil, completionHandler: { (isCompleted) in
                completionHandler(isCompleted)
            })
        }
    }
    
    func uploadProduct(product: Product, imageURL: URL?,  completionHandler:@escaping (Bool) -> Void){
        self.ref = Database.database().reference()
        var  productData = Dictionary<String, Any>()
        productData["objectId"] = self.ref.childByAutoId().key
        productData["createdAt"] = ServerValue.timestamp()
        productData["updatedAt"] = ServerValue.timestamp()
        productData["image"] = imageURL?.absoluteString
        productData["name"] =  product.name
        productData["company"] =  product.company
        productData["price"] =  product.price
        productData["boughtCount"] =  product.boughtCount
        productData["viewingCount"] =  product.viewingCount
        
        self.ref.child( productDatabase).child( productData["objectId"] as! String).setValue(productData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                completionHandler(false)
            }
            else{
                completionHandler(true)
            }
        }
    }
    
    func downloadProducts(endValue: Double?, completionHandler:@escaping ([Product]) -> Void){
        var products = [Product]()
        ref = Database.database().reference().child(productDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "createdAt").queryEnding(atValue: endValue).queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(products)
                return
            }
            
            for child in snapshot.children{
                //Create Product
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let product = self.createProduct(rawData: rawData)
                products.insert(product, at: 0)
            }
            completionHandler(products)
        })
    }
    
    func createProduct(rawData: [String: Any]) -> Product{
        let product = Product()
        product.objectId = rawData["objectId"] as? String
        product.createdAt = rawData["createdAt"] as! Double
        product.updatedAt = rawData["updatedAt"] as! Double
        product.image = rawData["image"] as? String
        product.company = rawData["company"] as? String
        product.name = rawData["name"] as? String
        product.price = rawData["price"] as! Double
        product.details = rawData["details"] as? String
        product.boughtCount = rawData["boughtCount"] as? Int
        product.viewingCount = rawData["viewingCount"] as? Int
        product.category = rawData["category"] as? String
        
        return product
    }
}
