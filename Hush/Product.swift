//
//  Product.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class Product: NSObject{
    var objectId: String!
    var createdAt = Double()
    var updatedAt = Double()
    var image: String!
    var company: String!
    var name: String!
    var details: String!
    var price = Double()
    var boughtCount: Int!
    var viewingCount: Int!
    var category: String!
}
