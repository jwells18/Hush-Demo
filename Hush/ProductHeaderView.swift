//
//  ProductHeaderView.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ProductHeaderView: UIView{
    
    var descriptionContainerView = UIView()
    var companyLabel = UILabel()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    var boughtStatisticsButton = ProductStatisticsButton()
    var viewingStatisticsButton = ProductStatisticsButton()
    var product: Product!
    
    convenience init(product: Product) {
        self.init()
        self.product = product
        //Setup View
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = true
        
        //Setup Description ContainerView
        self.setupDescriptionContainerView()
        
        //Setup Company Label
        self.setupCompanyLabel()
        
        //Setup Name Label
        self.setupNameLabel()
        
        //Setup Price Label
        self.setupPriceLabel()
        
        //Setup Bought Statistics Button
        self.setupBoughtStatisticsButton()
        
        //Setup Viewing Statistics Button
        self.setupViewingStatisticsButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupDescriptionContainerView(){
        descriptionContainerView.backgroundColor = .white
        descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionContainerView)
    }
    
    func setupCompanyLabel(){
        self.companyLabel.text = product?.company
        companyLabel.textColor = .lightGray
        companyLabel.font = UIFont.systemFont(ofSize: 12)
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(companyLabel)
    }
    
    func setupNameLabel(){
        self.nameLabel.text = product?.name
        nameLabel.textColor = .darkGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.addSubview(nameLabel)
    }
    
    func setupPriceLabel(){
        switch product?.price != nil {
        case true:
            let priceNumber  = NSNumber(value: (product?.price)!)
            self.priceLabel.text  = String(priceNumber.currencyString(maxFractionDigits: 2))
        case false:
            self.priceLabel.text  = ""
        }
        priceLabel.textColor = HSColor.primary
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
    }
    
    func setupBoughtStatisticsButton(){
        switch product?.boughtCount != nil {
        case true:
            let boughtCountNumber = NSNumber(value: (product?.boughtCount)!)
            let boughtCountText = String(format: "%@ %@", String(boughtCountNumber.shortNumberString(style: .none)), "bought".localized())
            boughtStatisticsButton.configure(image: UIImage(named: "bought") ,title: boughtCountText)
        case false:
            boughtStatisticsButton.configure(image: UIImage(named: "bought") ,title: "0")
        }
        boughtStatisticsButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boughtStatisticsButton)
    }
    
    func setupViewingStatisticsButton(){
        switch product?.viewingCount != nil {
        case true:
            let viewingCountNumber = NSNumber(value: (product?.viewingCount)!)
            let viewingCountText = String(format: "%@ %@", String(viewingCountNumber.shortNumberString(style: .none)), "viewing".localized())
            viewingStatisticsButton.configure(image: UIImage(named: "viewing") ,title: viewingCountText)
        case false:
            viewingStatisticsButton.configure(image: UIImage(named: "viewing") ,title: "0")
        }
        viewingStatisticsButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewingStatisticsButton)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["descriptionContainerView": descriptionContainerView, "companyLabel": companyLabel, "nameLabel": nameLabel, "priceLabel": priceLabel, "boughtStatisticsButton": boughtStatisticsButton, "viewingStatisticsButton": viewingStatisticsButton, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[descriptionContainerView][spacerView][priceLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[companyLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[nameLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[boughtStatisticsButton]-[viewingStatisticsButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[descriptionContainerView]-[boughtStatisticsButton(20)]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: priceLabel, attribute: .centerY, relatedBy: .equal, toItem: descriptionContainerView, attribute: .centerY, multiplier: 1, constant: 0))
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[companyLabel]-2-[nameLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: viewingStatisticsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: viewingStatisticsButton, attribute: .top, relatedBy: .equal, toItem: boughtStatisticsButton, attribute: .top, multiplier: 1, constant: 0))
    }
}
