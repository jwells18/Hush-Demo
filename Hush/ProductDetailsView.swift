//
//  ProductDetailsView.swift
//  Hush
//
//  Created by Justin Wells on 6/11/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductDetailsView: UIView{
    
    var detailsTitleLabel = UILabel()
    var detailsSubTitleLabel = UILabel()
    var returnsTitleLabel = UILabel()
    var returnsSubTitleLabel = UILabel()
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
        self.backgroundColor = .white
        
        //Setup Details Title Label
        self.setupDetailsTitleLabel()
        
        //Setup Details sSubTitle Label
        self.setupDetailsSubTitleLabel()
        
        //Setup Returns Title Label
        self.setupReturnsTitleLabel()
        
        //Setup Returns SubTitle Label
        self.setupReturnsSubTitleLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupDetailsTitleLabel(){
        self.detailsTitleLabel.text = "details".localized()
        self.detailsTitleLabel.textColor = .darkGray
        self.detailsTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.detailsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.detailsTitleLabel)
    }
    
    func setupDetailsSubTitleLabel(){
        self.detailsSubTitleLabel.text = product.details
        self.detailsSubTitleLabel.textColor = .darkGray
        self.detailsSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.detailsSubTitleLabel.numberOfLines = 0
        self.detailsSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.detailsSubTitleLabel)
    }
    
    func setupReturnsTitleLabel(){
        self.returnsTitleLabel.text = "returns".localized()
        self.returnsTitleLabel.textColor = .darkGray
        self.returnsTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.returnsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.returnsTitleLabel)
    }
    
    func setupReturnsSubTitleLabel(){
        self.returnsSubTitleLabel.text = "returnPolicyText".localized()
        self.returnsSubTitleLabel.textColor = .darkGray
        self.returnsSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.returnsSubTitleLabel.numberOfLines = 0
        self.returnsSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.returnsSubTitleLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["detailsTitleLabel": detailsTitleLabel, "detailsSubTitleLabel": detailsSubTitleLabel, "returnsTitleLabel": returnsTitleLabel, "returnsSubTitleLabel": returnsSubTitleLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[detailsTitleLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[detailsSubTitleLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[returnsTitleLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[returnsSubTitleLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[detailsTitleLabel]-4-[detailsSubTitleLabel]-30-[returnsTitleLabel]-4-[returnsSubTitleLabel]-76-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
