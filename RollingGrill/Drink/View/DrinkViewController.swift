//
//  DrinkViewController.swift
//  Admiral's Cup
//
//  Created by Jal Irani on 7/28/17.
//  Copyright © 2017 Jal Irani. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var drinkTableView: UITableView!
    
    var drinkItemArray = ["Tomato Caprese Skewers", "Bacon and BBQ Infused Chicken Kabobs", "Garlic Glazed Shrimp Kabobs", "Shrimp Cocktail", "Veggie Tray", "Cheese Tray", "Fruit Salad Platter"]
    var drinkPriceArray = ["49.95", "79.95", "99.95", "16.95", "34.95", "49.95", "39.95"]
    var drinkDescriptionArray = ["Feeds up to 30 people", "Feeds up to 30 people", "Feeds up to 30 people", "Served with cocktail sauce and lemon. (Priced per pound)", "Feeds up to 30 people", "Serves 20-40 people", "Feeds up to 30 people"]
    
    fileprivate var filteredDrinkItem = [String]()
    fileprivate var filteredDrinkPrice = [String]()
    fileprivate var filteredDrinkDescription = [String]()
    fileprivate var filterring = false
    
    // RGB values for Big text: R:117 G:111 B:99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkTableView.tableFooterView = UIView()
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
        return self.filterring ? self.filteredDrinkItem.count : drinkItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkTableViewCell
        if self.filterring {
            cell.drinkItemLabel.text = self.filteredDrinkItem[indexPath.row]
            cell.drinkPriceLabel.text = self.filteredDrinkPrice[indexPath.row]
            cell.drinkDescriptionLabel.text = self.filteredDrinkDescription[indexPath.row]
        } else {
            cell.drinkItemLabel.text = drinkItemArray[indexPath.row]
            cell.drinkPriceLabel.text = "$" + drinkPriceArray[indexPath.row]
            cell.drinkDescriptionLabel.text = drinkDescriptionArray[indexPath.row]
        }
        
        cell.drinkItemLabel.textColor? = .itemName
        cell.drinkPriceLabel.textColor? = .itemName
        cell.drinkDescriptionLabel.textColor? = .itemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension DrinkViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            var index = 0
            var counter = 0
            self.filteredDrinkItem = self.drinkItemArray.filter({ (drink) -> Bool in
                if drink.lowercased().contains(text.lowercased()) {
                    filteredDrinkPrice.insert("$" + self.drinkPriceArray[index], at: counter)
                    filteredDrinkDescription.insert(self.drinkDescriptionArray[index], at: counter)
                    counter = counter + 1
                }
                index = index + 1
                return drink.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filteredDrinkItem = [String]()
            self.filteredDrinkPrice = [String]()
            self.filteredDrinkDescription = [String]()
        }
        self.drinkTableView.reloadData()
    }
}
