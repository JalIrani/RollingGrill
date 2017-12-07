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
    
    var sections = ["Sandwiches", "Specialty Sandwiches and Platters", "Lunch Special", "Sides", "Drinks"]
    
    var drinkItemsSectioned = [
        ["Pit Beef", "Pit Turkey", "Pit Ham", "Colossal Pit Beef (12oz)", "Roma Italian Sausage", "Two Meat Combo", "Three Meat Combo"],
        ["The Rolling Grill", "The Rolling Club", "The Meat Market", "Pit Beef Cheese Steak", "Hot Ham and Cheese", "Pit Beef Caesar Salad"],
        ["Choose any Pit Meat Sandwich", "Upgrade to French Fries"],
        ["Coleslaw", "Fresh Hand Cut Fries", "Baked Beans", "Three Cheese Mac N' Cheese"],
        ["Coke", "Diet Coke", "Sprite", "Bottled Water"]
    ]
    var drinkPricesSectioned = [
        ["7.25", "6.25", "6.25", "10.00", "6.25", "8.25", "9.25"],
        ["9.00", "9.50", "9.50", "9.50", "9.50", "7.50", "7.75"],
        ["8.50", "1.50"],
        ["2.25", "3.50", "2.25", "3.00"],
        ["1.25", "1.25", "1.25", "1.25"]
    ]
    var drinkDescriptionsSectioned = [
        ["Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "With Peppers and Onions\nAdd Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50", "Add Coleslaw to any sandwich - $1.00\nadd cheese - $.50"],
        ["Our Pit Beef topped with melted provolone cheese, caramelized onions, coleslaw and BBQ sauce served on a toasted brioche roll", "Our Pit Beef topped with mac and cheese, BBQ sauce, house tiger sauce, caramelized onions, cheddar cheese, and bacon on a toasted brioche roll", "Our Pit Beef, Pit Turkey, Roma Sausage topped with cheddar cheese, BBQ sauce, and our house tiger sauce served on a toasted sub roll", "Our Pit Beef with sauteed peppers and onions, melted provolone cheese, lettuce, tomato, and our house tiger sauce served on a toasted sub roll", "Our Pit Ham topped with melted cheddar cheese with our house tiger sauce served on a toasted brioche roll", "Our Pit Beef over a bed of crisp romaine lettuce, parmesan cheese, croutons and caesar dressing"],
        ["with chips and a drink", ""],
        ["", "", "", ""],
        ["", "", "", ""]
    ]
    
    var checked = [
        [false, false, false, false, false, false, false],
        [false, false, false, false, false, false, false],
        [false, false],
        [false, false, false, false],
        [false, false, false, false]
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
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.itemName]
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
        
        // Fails when filtering
        if !checked[indexPath.section][indexPath.row] {
            cell.drinkItemLabel.textColor? = .itemName
            cell.drinkPriceLabel.textColor? = .itemName
            cell.drinkDescriptionLabel.textColor? = .itemName
        } else {
            cell.drinkItemLabel.textColor? = UIColor.red
            cell.drinkPriceLabel.textColor? = UIColor.red
            cell.drinkDescriptionLabel.textColor? = UIColor.red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DrinkTableViewCell {
            if checked[indexPath.section][indexPath.row] == true {
                cell.drinkItemLabel.textColor = .itemName
                cell.drinkPriceLabel.textColor? = .itemName
                cell.drinkDescriptionLabel.textColor? = .itemName
                checked[indexPath.section][indexPath.row] = false
            } else {
                cell.drinkItemLabel.textColor = UIColor.red
                cell.drinkPriceLabel.textColor = UIColor.red
                cell.drinkDescriptionLabel.textColor = UIColor.red
                checked[indexPath.section][indexPath.row] = true
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("Deselected: \(drinkItemsSectioned[indexPath.section][indexPath.row])")
//        print(Double(drinkPricesSectioned[indexPath.section][indexPath.row])!)
//
//        let currentItem = tableView.cellForRow(at: indexPath) as! DrinkTableViewCell
//        currentItem.drinkItemLabel.textColor = .itemName
//    }
    
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
