//
//  ProductScrollView.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductScrollView: UIScrollView{
    
    var cancelButton = UIButton()
    var likeButton = UIButton()
    var productContainerView: ProductContainerView!
    var product: Product!
    
    convenience init(product: Product?) {
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
        self.alwaysBounceVertical = true
        
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup ProductContainerView
        self.setupProductContainerView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupNavigationBar(){
        //Cancel Button
        cancelButton.setImage(UIImage(named: "cancel")!.withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = .white
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cancelButton)
        
        //Like Button
        likeButton.setImage(UIImage(named: "love")!.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = .white
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButton)
    }
    
    func setupProductContainerView(){
        productContainerView = ProductContainerView(product: product)
        productContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productContainerView)
    }
    
    func setupConstraints(){
        let viewDict = ["cancelButton": cancelButton, "likeButton": likeButton, "productContainerView": productContainerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28))
        self.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .left, relatedBy: .equal, toItem: self.productContainerView, attribute: .left, multiplier: 1, constant: 16))
        self.addConstraint(NSLayoutConstraint.init(item: likeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28))
        self.addConstraint(NSLayoutConstraint.init(item: likeButton, attribute: .right, relatedBy: .equal, toItem: self.productContainerView, attribute: .right, multiplier: 1, constant: -16))
        self.addConstraint(NSLayoutConstraint.init(item: productContainerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: productContainerView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[cancelButton(28)]-[productContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: likeButton, attribute: .height, relatedBy: .equal, toItem: cancelButton, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: likeButton, attribute: .centerY, relatedBy: .equal, toItem: cancelButton, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
