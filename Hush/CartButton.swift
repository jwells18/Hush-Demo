//
//  CartButton.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class CartButton: UIButton{
    
    var countButton = UIButton()
    var cartLabel = UILabel()
    var subTotalButton = UIButton()
    
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
        
        //Setup Count Button
        self.setupCountButton()
        
        //Setup View Cart Label
        self.setupCartLabel()
        
        //Setup SubTotal Button
        self.setupSubTotalButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCountButton(){
        countButton.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        countButton.setTitleColor(.white, for: .normal)
        countButton.titleLabel?.font = UIFont.boldSystemFont(ofSize:  18)
        countButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        countButton.layer.borderWidth = 1
        countButton.layer.borderColor = HSColor.primaryDark.cgColor
        countButton.layer.cornerRadius = 30/2
        countButton.isUserInteractionEnabled = false
        countButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countButton)
    }
    
    func setupCartLabel(){
        cartLabel.text = "addToCart".localized().uppercased()
        cartLabel.textColor = .white
        cartLabel.font = UIFont.boldSystemFont(ofSize:  18)
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartLabel)
    }
    
    func setupSubTotalButton(){
        subTotalButton.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        subTotalButton.setTitleColor(.white, for: .normal)
        subTotalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize:  18)
        subTotalButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        subTotalButton.layer.borderWidth = 1
        subTotalButton.layer.borderColor = HSColor.primaryDark.cgColor
        subTotalButton.layer.cornerRadius = 5
        subTotalButton.isUserInteractionEnabled = false
        subTotalButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTotalButton)
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
        
        let viewDict = ["countButton": countButton, "cartLabel": cartLabel, "subTotalButton": subTotalButton, "spacerViewLeft": spacerViewLeft, "spacerViewRight": spacerViewRight] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[countButton(>=30)][spacerViewLeft][cartLabel][spacerViewRight][subTotalButton]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: cartLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: countButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: countButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: cartLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: cartLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: subTotalButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: subTotalButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewLeft, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewLeft, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewRight, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewRight, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
    }
    
    func configure(){
        self.countButton.setTitle("0", for: .normal)
        self.subTotalButton.setTitle("$0.00", for: .normal)
    }
}
