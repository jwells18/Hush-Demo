//
//  FacebookSignupButton.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FacebookSignupButton: UIButton{
    
    var textLabel = UILabel()
    var iconView = UIImageView()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = HSColor.facebookBlue
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        //Setup TextLabel
        self.setupTextLabel()
        
        //Setup IconView
        self.setupIconView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTextLabel(){
        textLabel.text = "facebookSignup".localized().uppercased()
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
    }
    
    func setupIconView(){
        iconView.image = UIImage(named: "facebook")!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .white
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
    }
    
    func setupConstraints(){
        let spacerViewLeft = UIView()
        spacerViewLeft.isUserInteractionEnabled = false
        spacerViewLeft.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewLeft)
        let spacerViewRight = UIView()
        spacerViewRight.isUserInteractionEnabled = false
        spacerViewRight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewRight)
        
        let viewDict = ["textLabel": textLabel, "iconView": iconView, "spacerViewLeft": spacerViewLeft, "spacerViewRight": spacerViewRight] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[iconView(25)][spacerViewLeft(==spacerViewRight)][textLabel][spacerViewRight(==spacerViewLeft)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
    }
}
