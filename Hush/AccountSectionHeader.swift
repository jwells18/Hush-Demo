//
//  AccountSectionHeader.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class AccountSectionHeader: UIView{
    
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[titleLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(title: String){
        self.titleLabel.text = title.localized()
    }
}
