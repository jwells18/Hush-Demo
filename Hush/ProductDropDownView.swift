//
//  ProductDropDownView.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol ProductDropDownViewDelegate {
    func didPressBottomViewCancelButton(sender: UIButton)
}

class ProductDropDownView: UIView{
    
    var productDropDownViewDelegate: ProductDropDownViewDelegate!
    var topView = ProductDropDownTopView()
    var bottomView = ProductDropDownBottomView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = HSColor.primary
        
        //Setup TopView
        self.setupTopView()
        
        //Setup Bottom View
        self.setupBottomView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTopView(){
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topView)
    }
    
    func setupBottomView(){
        bottomView.cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
    }
    
    func setupConstraints(){
        let viewDict = ["topView": topView, "bottomView": bottomView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topView(30)][bottomView(90)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(product: Product?){
        topView.configure(product: product)
        bottomView.configure(product: product)
    }
    
    //Button Delegates
    func cancelButtonPressed(sender: UIButton){
        productDropDownViewDelegate.didPressBottomViewCancelButton(sender: sender)
    }
}
