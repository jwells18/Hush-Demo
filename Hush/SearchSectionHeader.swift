
//
//  SearchSectionHeader.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchSectionHeader: UIView{
    
    var headerContainerView = UIView()
    var iconView = UIImageView()
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
        self.backgroundColor = HSColor.faintGray
        
        //Setup Header ContainerView
        self.setupHeaderContainerView()
        
        //Setup IconView
        self.setupIconView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHeaderContainerView(){
        self.headerContainerView.backgroundColor = .white
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerContainerView)
    }
    
    func setupIconView(){
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(iconView)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["headerContainerView": headerContainerView, "titleLabel": titleLabel, "iconView": iconView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: headerContainerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: headerContainerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.headerContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[iconView(25)]-[titleLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: headerContainerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: headerContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -10))
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self.headerContainerView, attribute: .height, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
    }
    
    func configure(image: UIImage?, title: String){
        self.iconView.image = image
        self.titleLabel.text = title.localized()
    }
}
