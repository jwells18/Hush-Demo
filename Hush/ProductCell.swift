//
//  ProductCell.swift
//  Hush
//
//  Created by Justin Wells on 6/7/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProductCellDelegate {
    func relayDidPressLikeButton(sender: UIButton)
    func relayDidPressAddToCartButton(sender: UIButton)
}

class ProductCell: UICollectionViewCell{
    
    var productCellDelegate: ProductCellDelegate!
    var likeButton = UIButton()
    var imageView = UIImageView()
    var descriptionContainerView = UIView()
    var companyLabel = UILabel()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var boughtContainerView = UIView()
    var boughtCountLabel = UILabel()
    var boughtLabel = UILabel()
    var separatorLine = UIView()
    var viewingContainerView = UIView()
    var viewingCountLabel = UILabel()
    var viewingLabel = UILabel()
    var addToCartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = HSColor.faintGray
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        //Setup ImageView
        imageView.backgroundColor = HSColor.faintGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        //Setup Container View
        descriptionContainerView.backgroundColor = .white
        descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionContainerView)
        
        //Setup Company Label
        companyLabel.textColor = .lightGray
        companyLabel.font = UIFont.systemFont(ofSize: 12)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(companyLabel)
        
        //Setup Name Label
        nameLabel.textColor = .darkGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(nameLabel)
        
        //Setup Price Label
        priceLabel.textColor = HSColor.primary
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(priceLabel)
        
        //Setup Bought Container View
        boughtContainerView.backgroundColor = HSColor.faintGray
        boughtContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boughtContainerView)
        
        //Setup Bought Count Label
        boughtCountLabel.textColor = .darkGray
        boughtCountLabel.font = UIFont.boldSystemFont(ofSize: 12)
        boughtCountLabel.textAlignment = .center
        boughtCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.boughtContainerView.addSubview(boughtCountLabel)
        
        //Setup Bought Label
        boughtLabel.text  = "bought".localized()
        boughtLabel.textColor = .darkGray
        boughtLabel.font = UIFont.systemFont(ofSize: 12)
        boughtLabel.textAlignment = .center
        boughtLabel.translatesAutoresizingMaskIntoConstraints = false
        self.boughtContainerView.addSubview(boughtLabel)
        
        //Setup Separator Line
        self.separatorLine.backgroundColor = .gray
        self.separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorLine)
        
        //Setup View Container View
        self.viewingContainerView.backgroundColor = HSColor.faintGray
        self.viewingContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewingContainerView)
        
        //Setup View Count Label
        viewingCountLabel.textColor = .darkGray
        viewingCountLabel.font = UIFont.boldSystemFont(ofSize: 12)
        viewingCountLabel.textAlignment = .center
        viewingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.viewingContainerView.addSubview(viewingCountLabel)
        
        //Setup View Label
        viewingLabel.text  = "viewing".localized()
        viewingLabel.textColor = .darkGray
        viewingLabel.font = UIFont.systemFont(ofSize: 12)
        viewingLabel.textAlignment = .center
        viewingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.viewingContainerView.addSubview(viewingLabel)
        
        //Setup Like Button
        likeButton.setImage(UIImage(named: "loveSmall"), for: .normal)
        likeButton.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.6)
        likeButton.layer.cornerRadius = 25/2
        likeButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButton)
        
        //Setup Book Button
        addToCartButton.setTitle("addToCart".localized().uppercased(), for: .normal)
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        addToCartButton.backgroundColor = HSColor.primary
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addToCartButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewBoughtTop = UIView()
        spacerViewBoughtTop.isUserInteractionEnabled = false
        spacerViewBoughtTop.translatesAutoresizingMaskIntoConstraints = false
        self.boughtContainerView.addSubview(spacerViewBoughtTop)
        let spacerViewBoughtBottom = UIView()
        spacerViewBoughtBottom.isUserInteractionEnabled = false
        spacerViewBoughtBottom.translatesAutoresizingMaskIntoConstraints = false
        self.boughtContainerView.addSubview(spacerViewBoughtBottom)
        let spacerViewViewingTop = UIView()
        spacerViewViewingTop.isUserInteractionEnabled = false
        spacerViewViewingTop.translatesAutoresizingMaskIntoConstraints = false
        self.viewingContainerView.addSubview(spacerViewViewingTop)
        let spacerViewViewingBottom = UIView()
        spacerViewViewingBottom.isUserInteractionEnabled = false
        spacerViewViewingBottom.translatesAutoresizingMaskIntoConstraints = false
        self.viewingContainerView.addSubview(spacerViewViewingBottom)
        
        let viewDict = ["likeButton": likeButton, "imageView": imageView, "descriptionContainerView": descriptionContainerView, "companyLabel": companyLabel, "nameLabel": nameLabel, "priceLabel": priceLabel, "boughtContainerView": boughtContainerView, "boughtCountLabel": boughtCountLabel, "boughtLabel": boughtLabel, "separatorLine": separatorLine, "viewingContainerView": viewingContainerView, "viewingCountLabel": viewingCountLabel, "viewingLabel": viewingLabel, "addToCartButton": addToCartButton, "spacerViewBoughtTop": spacerViewBoughtTop, "spacerViewBoughtBottom": spacerViewBoughtBottom, "spacerViewViewingTop": spacerViewViewingTop, "spacerViewViewingBottom": spacerViewViewingBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[descriptionContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[companyLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[priceLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[boughtContainerView(==viewingContainerView)][separatorLine(0.5)][viewingContainerView(==boughtContainerView)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.boughtContainerView.addConstraint(NSLayoutConstraint.init(item: boughtCountLabel, attribute: .width, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .width, multiplier: 1, constant: 0))
        self.boughtContainerView.addConstraint(NSLayoutConstraint.init(item: boughtCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.boughtContainerView.addConstraint(NSLayoutConstraint.init(item: boughtLabel, attribute: .width, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .width, multiplier: 1, constant: 0))
        self.boughtContainerView.addConstraint(NSLayoutConstraint.init(item: boughtLabel, attribute: .centerX, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.viewingContainerView.addConstraint(NSLayoutConstraint.init(item: viewingCountLabel, attribute: .width, relatedBy: .equal, toItem: self.viewingContainerView, attribute: .width, multiplier: 1, constant: 0))
        self.viewingContainerView.addConstraint(NSLayoutConstraint.init(item: viewingCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self.viewingContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.viewingContainerView.addConstraint(NSLayoutConstraint.init(item: viewingLabel, attribute: .width, relatedBy: .equal, toItem: self.viewingContainerView, attribute: .width, multiplier: 1, constant: 0))
        self.viewingContainerView.addConstraint(NSLayoutConstraint.init(item: viewingLabel, attribute: .centerX, relatedBy: .equal, toItem: self.viewingContainerView, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[addToCartButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[likeButton(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView][descriptionContainerView(100)][boughtContainerView(50)][addToCartButton(40)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: viewingContainerView, attribute: .height, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: viewingContainerView, attribute: .top, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .top, multiplier: 1, constant: 0))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[companyLabel(20)][nameLabel(44)][priceLabel(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[likeButton(25)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.boughtContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewBoughtTop(==spacerViewBoughtBottom)][boughtCountLabel][boughtLabel][spacerViewBoughtBottom(==spacerViewBoughtTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .height, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: separatorLine, attribute: .centerY, relatedBy: .equal, toItem: self.boughtContainerView, attribute: .centerY, multiplier: 1, constant: 0))
        self.viewingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewViewingTop(==spacerViewViewingBottom)][viewingCountLabel][viewingLabel][spacerViewViewingBottom(==spacerViewViewingTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
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
    
    func likeButtonPressed(sender: UIButton){
        productCellDelegate.relayDidPressLikeButton(sender: sender)
    }
    
    func addToCartButtonPressed(sender: UIButton){
        productCellDelegate.relayDidPressAddToCartButton(sender: sender)
    }
}
