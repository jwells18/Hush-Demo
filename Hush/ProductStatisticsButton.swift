//
//  ProductStatisticsButton.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductStatisticsButton: UIButton{
    
    var iconView = UIImageView()
    var textLabel = UILabel()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = HSColor.faintGray
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        //Setup IconView
        self.setupIconView()
        
        //Setup TextLabel
        self.setupTextLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupIconView(){
        iconView.tintColor = .gray
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
    }
    
    func setupTextLabel(){
        textLabel.textAlignment = .center
        textLabel.textColor = .gray
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabel)
    }
    
    func setupConstraints(){
        let viewDict = ["textLabel": textLabel, "iconView": iconView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[iconView(12)]-[textLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: iconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 12)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func configure(image: UIImage? ,title: String?){
        if image != nil{
            iconView.image = image!.withRenderingMode(.alwaysTemplate)
        }
        textLabel.text = title
    }
}
