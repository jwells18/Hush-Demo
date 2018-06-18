//
//  AccountController.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class AccountController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    private let cellIdentifier = "cell"
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "accountVCTitle".localized()
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Prevent layout change when status bar is hidden
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.lightGray
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccountCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        //Set TableView Footer
        let accountSectionFooter = AccountSectionFooter(frame: .zero)
        accountSectionFooter.frame.size.height = 100
        tableView.tableFooterView = accountSectionFooter
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return accountTitles.count
        case 1:
            return supportTitles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let accountSectionHeader = AccountSectionHeader(frame: .zero)
        accountSectionHeader.configure(title: accountSectionTitles[section])
        return accountSectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountCell
        switch indexPath.section{
        case 0:
            cell.configure(title: accountTitles[indexPath.row].localized())
        case 1:
            cell.configure(title: supportTitles[indexPath.row].localized())
        default:
            break
        }
        
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                //Login or Signup
                let welcomeVC = WelcomeController()
                welcomeVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(welcomeVC, animated: true)
            default:
                break
            }
        case 1:
            switch indexPath.row{
            case 0:
                //FAQ
                let url = URL(string: "faqURL".localized())!
                let webViewVC = HSWebController(url: url)
                webViewVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(webViewVC, animated: true)
            case 1:
                //Show Feature Unavailable
                self.present(featureUnavailableAlert(), animated: true, completion: nil)
            case 2:
                //Privacy Policy
                let url = URL(string: "privacyURL".localized())!
                let webViewVC = HSWebController(url: url)
                webViewVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(webViewVC, animated: true)
            case 3:
                //End User Agreement
                let url = URL(string: "endUserAgreementURL".localized())!
                let webViewVC = HSWebController(url: url)
                webViewVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(webViewVC, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}
