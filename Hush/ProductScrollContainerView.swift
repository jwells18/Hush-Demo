//
//  ProductScrollContainerView.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductScrollContainerView: UIView{
    
    var scrollView: ProductScrollView!
    var product: Product!
    
    convenience init(product: Product) {
        self.init()
        self.product = product
        //Setup View
        self.setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.clipsToBounds = true
        
        //Setup ScrollView
        self.setupScrollView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupScrollView(){
        scrollView = ProductScrollView(product: product)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
    }
}
