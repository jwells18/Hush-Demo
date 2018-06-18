//
//  ProductDropDownBottomView.swift
//  Hush
//
//  Created by Justin Wells on 6/10/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDropDownBottomView: UIView{
    
    var cancelButton = UIButton()
    var descriptionContainerView = UIView()
    var companyLabel = UILabel()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var imageView = UIImageView()
    
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
        
        //Setup CancelButton
        self.setupCancelButton()
        
        //Setup Description ContainerView
        self.setupDescriptionContainerView()
        
        //Setup Company Label
        self.setupCompanyLabel()
        
        //Setup Name Label
        self.setupNameLabel()
        
        //Setup Price Label
        self.setupPriceLabel()
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCancelButton(){
        cancelButton.setImage(UIImage(named: "cancel")!.withRenderingMode(.alwaysTemplate), for: .normal)
        cancelButton.tintColor = .darkGray
        cancelButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cancelButton)
    }
    
    func setupDescriptionContainerView(){
        descriptionContainerView.backgroundColor = .white
        descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionContainerView)
    }
    
    func setupCompanyLabel(){
        companyLabel.textColor = .lightGray
        companyLabel.font = UIFont.systemFont(ofSize: 12)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(companyLabel)
    }
    
    func setupNameLabel(){
        nameLabel.textColor = .darkGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(nameLabel)
    }
    
    func setupPriceLabel(){
        priceLabel.textColor = HSColor.primary
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(priceLabel)
    }
    
    func setupImageView(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 5
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["cancelButton": cancelButton, "descriptionContainerView": descriptionContainerView, "companyLabel": companyLabel, "nameLabel": nameLabel, "priceLabel": priceLabel, "imageView": imageView, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[cancelButton(28)]-[descriptionContainerView][spacerView][imageView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[companyLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[priceLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 0.7, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 28))
        self.addConstraint(NSLayoutConstraint.init(item: cancelButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: descriptionContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 56))
        self.addConstraint(NSLayoutConstraint.init(item: descriptionContainerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[companyLabel(16)]-2-[nameLabel(18)]-2-[priceLabel(18)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -16))
        self.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func configure(product: Product?){
        switch product?.image != nil {
        case true:
            self.imageView.sd_setImage(with: URL(string: (product?.image)!), placeholderImage: UIImage(named: "hushPlaceholder"), options: SDWebImageOptions.init(rawValue: 0), completed: nil)
        case false:
            self.imageView.image = UIImage(named: "sampleProductImage1")
        }
        self.companyLabel.text = product?.company
        self.nameLabel.text  = product?.name
        switch product?.price != nil {
        case true:
            let priceNumber  = NSNumber(value: (product?.price)!)
            self.priceLabel.text  = String(priceNumber.currencyString(maxFractionDigits: 2))
        case false:
            self.priceLabel.text  = ""
        }
    }
}
