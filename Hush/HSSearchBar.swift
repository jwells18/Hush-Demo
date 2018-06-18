//
//  HSSearchBar.swift
//  Hush
//
//  Created by Justin Wells on 6/9/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HSSearchBar: UISearchBar{
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    var preferredBackgroundColor: UIColor!
    
    override func draw(_ rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.backgroundColor = preferredBackgroundColor
            
            //Add Border
            searchField.clipsToBounds = true
            searchField.layer.cornerRadius = searchField.frame.height/2
            searchField.layer.borderWidth = 0.5
            searchField.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Setup SearchBar
        self.frame = frame
        self.searchBarStyle = .minimal
        self.isTranslucent = false
        self.tintColor = .gray
        self.barTintColor = HSColor.faintGray
        self.backgroundColor = .white
        
        //Set Default Values
        preferredFont = .boldSystemFont(ofSize: 12)
        preferredTextColor = .darkGray
        preferredBackgroundColor = HSColor.faintGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Find Index of SearchBar in Subviews
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self){
                index = i
                break
            }
        }
        
        return index
    }
}
