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
    
    var filterSection = ["None"]
    var filterSectionIndex = -1
    var drinkItemsSectionedFilter = [[String]]()
    var drinkPricesSectionedFilter = [[String]]()
    var drinkDescriptionsSectionedFilter = [[String]]()
    
    var sections = ["Sandwiches", "cyclops"]
    
    var drinkItemsSectioned = [
        ["Tomato Caprese Skewers", "Bacon and BBQ Infused Chicken Kabobs", "Garlic Glazed Shrimp Kabobs", "Shrimp Cocktail", "Veggie Tray", "Cheese Tray", "Fruit Salad Platter", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls"],
        ["poop"]
    ]
    var drinkPricesSectioned = [
        ["49.95", "79.95", "99.95", "16.95", "34.95", "49.95", "39.95", "55.00", "110.00", "210.00", "111.00", "222.00", "420.00"],
        ["3.00"]
    ]
    var drinkDescriptionsSectioned = [
        ["Feeds up to 30 people", "Feeds up to 30 people", "Feeds up to 30 people", "Served with cocktail sauce and lemon. (Priced per pound)", "Feeds up to 30 people", "Serves 20-40 people", "Feeds up to 30 people", "25ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "50ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "100ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "25ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon", "50ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon", "100ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon"],
        ["get some"]
    ]
    
    var drinkItemArray = [String]()
    var drinkPriceArray = [String]()
    var drinkDescriptionArray = [String]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("In view will appear:" + filterSection[0])
        if self.filterSection[0] != "None" {
            drinkItemsSectionedFilter.insert(self.drinkItemsSectioned[filterSectionIndex], at: 0)
            drinkPricesSectionedFilter.insert(self.drinkPricesSectioned[filterSectionIndex], at: 0)
            drinkDescriptionsSectionedFilter.insert(self.drinkDescriptionsSectioned[filterSectionIndex], at: 0)
            drinkItemArray = Array(drinkItemsSectionedFilter.joined())
            drinkPriceArray = Array(drinkPricesSectionedFilter.joined())
            drinkDescriptionArray = Array(drinkDescriptionsSectionedFilter.joined())
            print(drinkItemArray)
        } else {
            drinkItemArray = Array(drinkItemsSectioned.joined())
            drinkPriceArray = Array(drinkPricesSectioned.joined())
            drinkDescriptionArray = Array(drinkDescriptionsSectioned.joined())
            drinkItemsSectionedFilter = [[String]]()
            drinkPricesSectionedFilter = [[String]]()
            drinkDescriptionsSectionedFilter = [[String]]()
        }
        drinkTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.filterSection[0] != "None" {
            return self.filterring ? self.filteredDrinkItem.count : drinkItemsSectionedFilter[section].count
        } else {
            return self.filterring ? self.filteredDrinkItem.count : drinkItemsSectioned[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkTableViewCell
        if self.filterSection[0] != "None" {
            if self.filterring {
                //self.items[indexPath.section][indexPath.row]
                cell.drinkItemLabel.text = self.filteredDrinkItem[indexPath.row]
                cell.drinkPriceLabel.text = self.filteredDrinkPrice[indexPath.row]
                cell.drinkDescriptionLabel.text = self.filteredDrinkDescription[indexPath.row]
            } else {
                cell.drinkItemLabel.text = drinkItemsSectionedFilter[indexPath.section][indexPath.row]
                cell.drinkPriceLabel.text = "$" + drinkPricesSectionedFilter[indexPath.section][indexPath.row]
                cell.drinkDescriptionLabel.text = drinkDescriptionsSectionedFilter[indexPath.section][indexPath.row]
            }
        } else {
            if self.filterring {
                //self.items[indexPath.section][indexPath.row]
                cell.drinkItemLabel.text = self.filteredDrinkItem[indexPath.row]
                cell.drinkPriceLabel.text = self.filteredDrinkPrice[indexPath.row]
                cell.drinkDescriptionLabel.text = self.filteredDrinkDescription[indexPath.row]
            } else {
                cell.drinkItemLabel.text = drinkItemsSectioned[indexPath.section][indexPath.row]
                cell.drinkPriceLabel.text = "$" + drinkPricesSectioned[indexPath.section][indexPath.row]
                cell.drinkDescriptionLabel.text = drinkDescriptionsSectioned[indexPath.section][indexPath.row]
            }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.filterring || self.filterSection[0] != "None" {
            return 1
        } else {
            return sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.filterring {
            return "Filtered Results"
        } else if self.filterSection[0] != "None" {
            return filterSection[0]
        }
        else {
            return sections[section]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
    }
    
    @IBAction func unwindFilterDrink(_ sender: UIStoryboardSegue) {
        if sender.source is DrinkFilterViewController {
            if let filterVC = sender.source as? DrinkFilterViewController {
                self.filterSection[0] = filterVC.selectedFilter
                self.filterSectionIndex = filterVC.selectedIndex
            }
        }
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        filterSection[0] = "None"
        filterSectionIndex = -1
        drinkTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSectionsDrink" {
            if let secondController = segue.destination as? DrinkFilterViewController {
                print("In prepare for segue \(sections)")
                secondController.sectionsFilter = self.sections
            }
        }
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
