//
//  SearchFooterButton.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchFooterButton: UIButton{
    
    var textLabel = UILabel()
    var activityIndicatorView = UIActivityIndicatorView()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = HSColor.primary
        self.clipsToBounds = true
        
        //Setup TextLabel
        self.setupTextLabel()
        
        //Setup ActivityIndicatorView
        self.setupActivityIndicatorView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTextLabel(){
        textLabel.text = "loading".localized().uppercased()
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.font = UIFont.boldSystemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
    }
    
    func setupActivityIndicatorView(){
        activityIndicatorView.activityIndicatorViewStyle = .white
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicatorView)
    }
    
    func setupConstraints(){
        let viewDict = ["textLabel": textLabel, "activityIndicatorView": activityIndicatorView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-32-[textLabel]-[activityIndicatorView(16)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: activityIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16)])
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
