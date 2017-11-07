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
    
    var filterSection = [String]()
    
    var sections = ["Starters", "Platters for Delivery"]
    
    var menuItemsSectioned = [["Tomato Caprese Skewers", "Bacon and BBQ Infused Chicken Kabobs", "Garlic Glazed Shrimp Kabobs", "Shrimp Cocktail", "Veggie Tray", "Cheese Tray", "Fruit Salad Platter"], ["something"]]
    var menuPricesSectioned = [["49.95", "79.95", "99.95", "16.95", "34.95", "49.95", "39.95"], ["2.99"]]
    var menuDescriptionsSectioned = [["Feeds up to 30 people", "Feeds up to 30 people", "Feeds up to 30 people", "Served with cocktail sauce and lemon. (Priced per pound)", "Feeds up to 30 people", "Serves 20-40 people", "Feeds up to 30 people"], ["Keep feedin em"]]
    
    var menuItemArray = [String]()
    var menuPriceArray = [String]()
    var menuDescriptionArray = [String]()
    
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
        menuItemArray = Array(menuItemsSectioned.joined())
        menuPriceArray = Array(menuPricesSectioned.joined())
        menuDescriptionArray = Array(menuDescriptionsSectioned.joined())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //probabaly move - check if from filtered page or not
//        menuItemArray = Array(menuItemsSectioned.joined())
//        menuPriceArray = Array(menuPricesSectioned.joined())
//        menuDescriptionArray = Array(menuDescriptionsSectioned.joined())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterring ? self.filteredMenuItem.count : menuItemsSectioned[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        if self.filterring {
            //self.items[indexPath.section][indexPath.row]
            cell.menuItemLabel.text = self.filteredMenuItem[indexPath.row]
            cell.menuPriceLabel.text = self.filteredMenuPrice[indexPath.row]
            cell.menuDescriptionLabel.text = self.filteredMenuDescription[indexPath.row]
        } else {
            cell.menuItemLabel.text = menuItemsSectioned[indexPath.section][indexPath.row]
            cell.menuPriceLabel.text = "$" + menuPricesSectioned[indexPath.section][indexPath.row]
            cell.menuDescriptionLabel.text = menuDescriptionsSectioned[indexPath.section][indexPath.row]
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.filterring ? 1 : sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.filterring ? "Filtered Results" : sections[section]
        
    }
    
    @IBAction func unwindFilter(_ sender: UIStoryboardSegue) {
        if sender.source is MenuFilterViewController {
            if let filterVC = sender.source as? MenuFilterViewController {
                print(filterVC.selectedFilter)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSections" {
            if let secondController = segue.destination as? MenuFilterViewController {
                secondController.sectionsFilter = self.sections
            }
        }
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
