//
//  ProductDropDownTopView.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductDropDownTopView: UIView{
    
    private var gradient = CAGradientLayer()
    var titleLabel = UILabel()
    var viewingIconView = UIImageView()
    var viewingCountLabel = UILabel()
    var boughtIconView = UIImageView()
    var boughtCountLabel = UILabel()
    
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
        gradient.colors = [HSColor.tertiary.cgColor, HSColor.quaternary.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Viewing IconView
        self.setupViewingIconView()
        
        //Setup Viewing Count Label
        self.setupViewingCountLabel()
        
        //Setup Bought IconView
        self.setupBoughtIconView()
        
        //Setup Viewing Count Label
        self.setupBoughtCountLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        //Set titleLabel text with random affirmation
        let randomIndex = Int(arc4random_uniform(UInt32(positiveAffirmations.count)))
        titleLabel.text = positiveAffirmations[randomIndex].localized().uppercased()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize:  12)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupViewingIconView(){
        self.viewingIconView.image = UIImage(named: "viewing")
        self.viewingIconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewingIconView)
    }
    
    func setupViewingCountLabel(){
        self.viewingCountLabel.textColor = .white
        self.viewingCountLabel.font = UIFont.systemFont(ofSize:  12)
        self.viewingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewingCountLabel)
    }
    
    func setupBoughtIconView(){
        self.boughtIconView.image = UIImage(named: "bought")
        self.boughtIconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boughtIconView)
    }
    
    func setupBoughtCountLabel(){
        self.boughtCountLabel.textColor = .white
        self.boughtCountLabel.font = UIFont.systemFont(ofSize:  12)
        self.boughtCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boughtCountLabel)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["titleLabel": titleLabel, "viewingIconView": viewingIconView, "viewingCountLabel": viewingCountLabel, "boughtIconView": boughtIconView, "boughtCountLabel": boughtCountLabel, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[titleLabel][spacerView][viewingIconView(16)]-2-[viewingCountLabel]-16-[boughtIconView(16)]-2-[boughtCountLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16))
        self.addConstraint(NSLayoutConstraint.init(item: viewingIconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: viewingIconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12))
        self.addConstraint(NSLayoutConstraint.init(item: viewingCountLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: viewingCountLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16))
        self.addConstraint(NSLayoutConstraint.init(item: boughtIconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: boughtIconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12))
        self.addConstraint(NSLayoutConstraint.init(item: boughtCountLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: boughtCountLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    func configure(product: Product?){
        switch product?.boughtCount != nil {
        case true:
            let boughtCountNumber = NSNumber(value: (product?.boughtCount)!)
            self.boughtCountLabel.text = String(boughtCountNumber.shortNumberString(style: .none))
        case false:
            self.boughtCountLabel.text = "0"
        }
        switch product?.viewingCount != nil {
        case true:
            let viewingCountNumber = NSNumber(value: (product?.viewingCount)!)
            self.viewingCountLabel.text  = String(viewingCountNumber.shortNumberString(style: .none))
        case false:
            self.viewingCountLabel.text  = "0"
        }
    }
}
