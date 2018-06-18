//
//  BrowseHeader.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BrowseHeader: UIView{
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var spinWheelView = BrowseSpinWheelView()
    var seePrizesButton = UIButton()
    private var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Set Gradient Background
        gradient.colors = [UIColor.white.cgColor, HSColor.faintGray.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = true
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Spin Wheel View
        self.setupSpinWheelView()
        
        //Setup See Prizes Button
        self.setupSeePrizesButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.text = "browseHeaderTitle".localized().uppercased()
        self.titleLabel.textColor = .darkGray
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.text = "browseHeaderSubTitle".localized()
        self.subTitleLabel.textColor = .darkGray
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupSpinWheelView(){
        self.spinWheelView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinWheelView)
    }
    
    func setupSeePrizesButton(){
        self.seePrizesButton.setTitle("seePrizes".localized().uppercased(), for: .normal)
        self.seePrizesButton.setTitleColor(.gray, for: .normal)
        self.seePrizesButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.seePrizesButton.layer.borderColor = UIColor.gray.cgColor
        self.seePrizesButton.layer.borderWidth = 0.5
        self.seePrizesButton.layer.cornerRadius = 5
        self.seePrizesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.seePrizesButton)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spinWheelView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spinWheelView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: seePrizesButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.addConstraint(NSLayoutConstraint.init(item: seePrizesButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: subTitleLabel, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        self.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spinWheelView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: spinWheelView, attribute: .top, relatedBy: .equal, toItem: subTitleLabel, attribute: .bottom, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint.init(item: seePrizesButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        self.addConstraint(NSLayoutConstraint.init(item: seePrizesButton, attribute: .top, relatedBy: .equal, toItem: spinWheelView, attribute: .bottom, multiplier: 1, constant: 5))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
}

