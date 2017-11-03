//
//  MenuViewController.swift
//  Admiral's Cup
//
//  Created by Jal Irani on 7/27/17.
//  Copyright © 2017 Jal Irani. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!
    
    var sections = ["Starters", "Platters for Delivery"]
    
    var menuItemArray = ["Tomato Caprese Skewers", "Bacon and BBQ Infused Chicken Kabobs", "Garlic Glazed Shrimp Kabobs", "Shrimp Cocktail", "Veggie Tray", "Cheese Tray", "Fruit Salad Platter"]
    var menuPriceArray = ["49.95", "79.95", "99.95", "16.95", "34.95", "49.95", "39.95"]
    var menuDescriptionArray = ["Feeds up to 30 people", "Feeds up to 30 people", "Feeds up to 30 people", "Served with cocktail sauce and lemon. (Priced per pound)", "Feeds up to 30 people", "Serves 20-40 people", "Feeds up to 30 people"]
    
    fileprivate var filteredMenuItem = [String]()
    fileprivate var filteredMenuPrice = [String]()
    fileprivate var filteredMenuDescription = [String]()
    fileprivate var filterring = false
    
    // RGB values for Big text: R:117 G:111 B:99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.itemName]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.itemName]
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as UISearchResultsUpdating
        self.navigationItem.searchController = search
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterring ? self.filteredMenuItem.count : menuItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        if self.filterring {
            cell.menuItemLabel.text = self.filteredMenuItem[indexPath.row]
            cell.menuPriceLabel.text = self.filteredMenuPrice[indexPath.row]
            cell.menuDescriptionLabel.text = self.filteredMenuDescription[indexPath.row]
        } else {
            cell.menuItemLabel.text = menuItemArray[indexPath.row]
            cell.menuPriceLabel.text = "$" + menuPriceArray[indexPath.row]
            cell.menuDescriptionLabel.text = menuDescriptionArray[indexPath.row]
        }
        
        cell.menuItemLabel.textColor? = .itemName
        cell.menuPriceLabel.textColor? = .itemName
        cell.menuDescriptionLabel.textColor? = .itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MenuViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            var index = 0
            var counter = 0
            self.filteredMenuItem = self.menuItemArray.filter({ (drink) -> Bool in
                if drink.lowercased().contains(text.lowercased()) {
                    filteredMenuPrice.insert("$" + self.menuPriceArray[index], at: counter)
                    filteredMenuDescription.insert(self.menuDescriptionArray[index], at: counter)
                    counter = counter + 1
                }
                index = index + 1
                return drink.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filteredMenuItem = [String]()
            self.filteredMenuPrice = [String]()
            self.filteredMenuDescription = [String]()
        }
        self.menuTableView.reloadData()
    }
}
