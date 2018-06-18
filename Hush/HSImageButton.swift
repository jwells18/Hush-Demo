//
//  HSImageButton.swift
//  Hush
//
//  Created by Justin Wells on 6/8/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HSImageButton: UIButton{

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
        self.contentMode = .scaleAspectFill
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.showsTouchWhenHighlighted = false
        self.adjustsImageWhenHighlighted = false
    }
}
