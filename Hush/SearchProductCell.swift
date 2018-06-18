//
//  SearchProductCell.swift
//  Hush
//
//  Created by Justin Wells on 6/12/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

class SearchProductCell: UITableViewCell{
    
    var mainImageView = UIImageView()
    var titleContainerView = UIView()
    var mainTitleLabel = UILabel()
    var mainSubTitleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        //Setup ImageView
        self.mainImageView.clipsToBounds = true
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
        
        //Setup Title ContainerView
        self.titleContainerView.clipsToBounds = true
        self.titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleContainerView)
        
        //Setup Title Label
        self.mainTitleLabel.textColor = .darkGray
        self.mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleContainerView.addSubview(self.mainTitleLabel)
        
        //Setup SubTitle Label
        self.mainSubTitleLabel.textColor = .gray
        self.mainSubTitleLabel.numberOfLines = 1
        self.mainSubTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.mainSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleContainerView.addSubview(mainSubTitleLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.titleContainerView.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.titleContainerView.addSubview(spacerViewBottom)
        
        let viewDict = ["mainImageView": mainImageView, "titleContainerView": titleContainerView, "mainTitleLabel": mainTitleLabel, "mainSubTitleLabel": mainSubTitleLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(50)]-[titleContainerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.titleContainerView.addConstraints([NSLayoutConstraint.init(item: mainTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleContainerView, attribute: .left, multiplier: 1, constant: 0)])
        self.titleContainerView.addConstraints([NSLayoutConstraint.init(item: mainTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleContainerView, attribute: .width, multiplier: 1, constant: 0)])
        self.titleContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleContainerView, attribute: .left, multiplier: 1, constant: 0)])
        self.titleContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleContainerView, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints([NSLayoutConstraint.init(item: titleContainerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: titleContainerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.titleContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][mainTitleLabel][mainSubTitleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
    }
    
    func configure(product: Product?){
        //Set ImageView Image
        if product?.image != nil{
            mainImageView.sd_setImage(with: URL(string: (product?.image)!), placeholderImage: UIImage(named: "hushPlaceholder"))
        }
        else{
            mainImageView.image = UIImage(named: "hushPlaceholder")
        }
        mainTitleLabel.text = product?.company
        mainSubTitleLabel.text = product?.name
    }
}
