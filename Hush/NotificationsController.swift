//
//  NotificationsController.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "notificationsVCTitle".localized()
    }
    
    func setupView(){
        //Set Background Color
        self.view.backgroundColor = HSColor.faintGray
    }
}
