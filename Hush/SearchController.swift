//
//  SearchController.swift
//  Hush
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SearchSectionFooterDelegate{
    
    private let peopleCellIdentifier = "peopleCell"
    private let productCellIdentifier = "productCell"
    private var tableView: UITableView!
    private var searchBar = HSSearchBar()
    private var users: [User]!
    private var products: [Product]!
    private var isDownloading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //Download Data
        self.downloadData(endValue: currentTimestamp())
    }
    
    func setupNavigationBar(){
        //Setup SearchBar
        searchBar.placeholder = "searchHush".localized()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func setupView(){
        self.view.backgroundColor = HSColor.faintGray
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = HSColor.faintGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset  = .zero
        tableView.separatorColor = HSColor.faintGray
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchPeopleCell.self, forCellReuseIdentifier: peopleCellIdentifier)
        tableView.register(SearchProductCell.self, forCellReuseIdentifier: productCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(endValue: Double?){
        //Download Users & Product Data
        let userManager = UserManager()
        let productManager = ProductManager()
        userManager.downloadUsers(endValue: endValue) { (users) in
            self.users = users
            
            //Search for products
            productManager.downloadProducts(endValue: endValue, completionHandler: { (products) in
                self.products = products
                self.isDownloading = false
                self.tableView.reloadData()
            })
        }
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            if users != nil{
                switch users.count{
                case _ where users.count < 3:
                    return users.count
                case _ where users.count >= 3:
                    return 3
                default:
                    return 0
                }
            }
            else{
                return 0
            }
            
        case 1:
            if products != nil{
                switch products.count{
                case _ where products.count < 3:
                    return products.count
                case _ where products.count >= 3:
                    return 3
                default:
                    return 0
                }
            }
            else{
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SearchSectionHeader()
        headerView.configure(image: searchSectionImages[section], title: searchSectionTitles[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = SearchSectionFooter()
        footerView.searchSectionFooterDelegate = self
        switch isDownloading {
        case true:
            footerView.searchFooterButton.isHidden = false
            footerView.searchFooterButton.textLabel.text = "loading".localized().uppercased()
            footerView.searchFooterButton.activityIndicatorView.startAnimating()
        case false:
            switch section{
            case 0:
                //TODO: Add No Results background label
                footerView.searchFooterButton.isHidden = false
                footerView.searchFooterButton.textLabel.text = "showMorePeople".localized().uppercased()
                footerView.searchFooterButton.activityIndicatorView.stopAnimating()
            case 1:
                //TODO: Add No Results background label
                footerView.searchFooterButton.isHidden = false
                footerView.searchFooterButton.textLabel.text = "showMoreProducts".localized().uppercased()
                footerView.searchFooterButton.activityIndicatorView.stopAnimating()
            default:
                footerView.searchFooterButton.isHidden = true
                footerView.searchFooterButton.activityIndicatorView.stopAnimating()
            }
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: peopleCellIdentifier, for: indexPath) as! SearchPeopleCell
            cell.configure(user: users[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier, for: indexPath) as! SearchProductCell
            cell.configure(product: products[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: peopleCellIdentifier, for: indexPath) as! SearchPeopleCell
            return cell
        }
    }
    
    //CollectionView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //SearchBar Delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Download data using search text and refresh tableView
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //Footer Delegate
    func didPressFooterButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}
