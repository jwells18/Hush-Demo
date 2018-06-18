//
//  SearchSectionFooter.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol SearchSectionFooterDelegate {
    func didPressFooterButton(sender: UIButton)
}

class SearchSectionFooter: UIView{
    
    var searchSectionFooterDelegate: SearchSectionFooterDelegate!
    var footerContainerView = UIView()
    var footerTextLabel = UILabel()
    var searchFooterButton = SearchFooterButton()
    
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
        
        //Setup Footer ContainerView
        self.setupFooterContainerView()
        
        //Setup Footer TextLabel
        self.setupFooterTextLabel()
        
        //Setup Search Footer Button
        self.setupSearchFooterButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupFooterContainerView(){
        self.footerContainerView.backgroundColor = .white
        self.footerContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(footerContainerView)
    }
    
    func setupFooterTextLabel(){
        self.footerTextLabel.isHidden = true
        self.footerTextLabel.textColor = .darkGray
        self.footerTextLabel.textAlignment = .center
        self.footerTextLabel.font = UIFont.systemFont(ofSize: 12)
        self.footerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.footerContainerView.addSubview(footerTextLabel)
    }
    
    func setupSearchFooterButton(){
        self.searchFooterButton.addTarget(self, action: #selector(self.footerButtonPressed), for: .touchUpInside)
        self.searchFooterButton.translatesAutoresizingMaskIntoConstraints = false
        self.footerContainerView.addSubview(searchFooterButton)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: footerContainerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: footerContainerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: footerTextLabel, attribute: .centerX, relatedBy: .equal, toItem: self.footerContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: footerTextLabel, attribute: .width, relatedBy: .equal, toItem: self.footerContainerView, attribute: .width, multiplier: 1, constant: 0))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: searchFooterButton, attribute: .centerX, relatedBy: .equal, toItem: self.footerContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: footerContainerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: footerContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -10))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: footerTextLabel, attribute: .centerY, relatedBy: .equal, toItem: self.footerContainerView, attribute: .centerY, multiplier: 1, constant: 0))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: footerTextLabel, attribute: .height, relatedBy: .equal, toItem: self.footerContainerView, attribute: .height, multiplier: 1, constant: 0))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: searchFooterButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.footerContainerView.addConstraint(NSLayoutConstraint.init(item: searchFooterButton, attribute: .centerY, relatedBy: .equal, toItem: self.footerContainerView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    //Delegate
    func footerButtonPressed(sender: UIButton){
        searchSectionFooterDelegate.didPressFooterButton(sender: sender)
    }
}
