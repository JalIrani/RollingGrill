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
    
    var filterSection = ["None"]
    var filterSectionIndex = -1
    var menuItemsSectionedFilter = [[String]]()
    var menuPricesSectionedFilter = [[String]]()
    var menuDescriptionsSectionedFilter = [[String]]()
    
    var sections = ["Starters", "Platters for Delivery", "Backyard BBQ", "Banquet Style Entrees", "Sides", "Raw Oysters", "Desserts", "Drinks", "Bartending Service"]
    
    var menuItemsSectioned = [
        ["Tomato Caprese Skewers", "Bacon and BBQ Infused Chicken Kabobs", "Garlic Glazed Shrimp Kabobs", "Shrimp Cocktail", "Veggie Tray", "Cheese Tray", "Fruit Salad Platter", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls", "Maryland Style Crab Balls"],
        ["Deli Platter - 12 Sandwiches", "Deli Platter - 24 Sandwiches", "Deli Platter - 48 Sandwiches", "Deli Platter - 100 Sandwiches", "Salad Platter - 12 Sandwiches", "Salad Platter - 24 Sandwiches", "Salad Platter - 48 Sandwiches", "Salad Platter - 100 Sandwiches", "Wing Platter - 50 Wings", "Wing Platter - 100 Wings"],
        ["Pit Beef", "Pit Turkey", "Pit Ham", "Roma Italian Sausage with Peppers and Onions", "Chicken Breast", "Angus Burger", "All Beef Hot Dog"],
        ["Bourbon BBQ Chicken", "Roast Beef Au Jus", "Shrimp Creole", "Broiled Salmon", "Penne Italiano"],
        ["Steamed Asparagus", "Fresh Green Beans", "Vegetable Medley", "Roasted Red Potatoes", "Coleslaw", "Baked Beans", "Potato Salad", "Pasta Salad", "Mac and Cheese", "Caesar Salad"],
        ["Delaware Bays - 100ct.", "Blue Points - 100ct."],
        ["Assorted Fruited Mini Cheesecakes 1 oz.", "Mini Black Bottoms", "9\" Cheesecakes- 12 Slices", "9\" Gourmet Cakes- 12 Slices", "Large Assorted Cookie Tray", "Small Cookie Tray"],
        ["Assorted Sodas and Bottled Water", "Fresh Squeezed Lemonade", "Sweet Iced Tea"],
        ["Priced Per Hour (4hr minimum)"]
    ]
    var menuPricesSectioned = [
        ["49.95", "79.95", "99.95", "16.95", "34.95", "49.95", "39.95", "55.00", "110.00", "210.00", "111.00", "222.00", "420.00"],
        ["35.00", "69.00", "135.00", "265.00", "25.00", "49.00", "95.00", "185.00", "47.95", "89.95"],
        ["3.95", "2.95", "2.95", "3.25", "3.95", "2.50", "1.95"],
        ["5.95", "5.95", "8.95", "10.50", "4.95"],
        ["3.25", "2.50", "2.50", "2.50", "2.25", "2.25", "2.25", "2.25", "2.50", "1.95"],
        ["110.00", "120.00"],
        ["21.95", "20.95", "57.95", "57.95", "47.95", "20.95"],
        ["2.00", "10.00", "5.00"],
        ["25.00"]
    ]
    var menuDescriptionsSectioned = [
        ["Feeds up to 30 people", "Feeds up to 30 people", "Feeds up to 30 people", "Served with cocktail sauce and lemon. (Priced per pound)", "Feeds up to 30 people", "Serves 20-40 people", "Feeds up to 30 people", "25ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "50ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "100ct- 1 oz. Balls\nServed with cocktail, tarter, and lemon", "25ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon", "50ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon", "100ct- 2 oz. Balls\nServed with cocktail, tarter, and lemon"],
        ["Pit Beef, Pit Turkey, Pit Ham (Choice of 2) served cold", "Pit Beef, Pit Turkey, Pit Ham (Choice of 2) served cold", "Pit Beef, Pit Turkey, Pit Ham (Choice of 2) served cold", "Pit Beef, Pit Turkey, Pit Ham (Choice of 2) served cold", "Chicken and Tuna Salad", "Chicken and Tuna Salad", "Chicken and Tuna Salad", "Chicken and Tuna Salad", "Your Choice of Buffalo, BBQ, or Old Bay. Served with Celery and Ranch", "Your Choice of Buffalo, BBQ, or Old Bay. Served with Celery and Ranch"],
        ["", "", "", "", "Your choice of BBQ or Blackened", "5 oz Patty-Fresh never frozen", ""],
        ["Slow roasted bone-in chicken thigh topped with sautéed peppers, onions, and pineapple, finished with a bourbon bbq sauce glaze", "Roast Beef in an Au Jus topped with sautéed mushrooms and fresh herbs", "Fresh shrimp, cooked in a spicy Creole tomato sauce and served over a hot bed of steaming rice", "Broiled 8 oz. salmon filet topped with a lemon butter sauce", "Baked penne pasta with a homemade tomato sauce including sautéed peppers, onions, and Roma sausage"],
        ["", "", "", "", "", "", "", "", "", ""],
        ["All oysters are served with cocktail sauce and lemon. Events requiring an oyster shucker will inquire an additional fee", "All oysters are served with cocktail sauce and lemon. Events requiring an oyster shucker will inquire an additional fee"],
        ["Priced Per Dozen", "Priced Per Dozen", "Ask about flavors!", "Ask about flavors!", "60 assorted cookies", ""],
        ["Priced Per Person", "Served by the gallon\nPriced Per Person", "Served by the gallon\nPriced Per Person"],
        ["All alcohol must be provided by host"]
    ]
    
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
        //navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("In view will appear:" + filterSection[0])
        if self.filterSection[0] != "None" {
            menuItemsSectionedFilter.insert(self.menuItemsSectioned[filterSectionIndex], at: 0)
            menuPricesSectionedFilter.insert(self.menuPricesSectioned[filterSectionIndex], at: 0)
            menuDescriptionsSectionedFilter.insert(self.menuDescriptionsSectioned[filterSectionIndex], at: 0)
            menuItemArray = Array(menuItemsSectionedFilter.joined())
            menuPriceArray = Array(menuPricesSectionedFilter.joined())
            menuDescriptionArray = Array(menuDescriptionsSectionedFilter.joined())
            print(menuItemArray)
        } else {
            menuItemArray = Array(menuItemsSectioned.joined())
            menuPriceArray = Array(menuPricesSectioned.joined())
            menuDescriptionArray = Array(menuDescriptionsSectioned.joined())
            menuItemsSectionedFilter = [[String]]()
            menuPricesSectionedFilter = [[String]]()
            menuDescriptionsSectionedFilter = [[String]]()
        }
        menuTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.filterSection[0] != "None" {
            return self.filterring ? self.filteredMenuItem.count : menuItemsSectionedFilter[section].count
        } else {
            return self.filterring ? self.filteredMenuItem.count : menuItemsSectioned[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        if self.filterSection[0] != "None" {
            if self.filterring {
                //self.items[indexPath.section][indexPath.row]
                cell.menuItemLabel.text = self.filteredMenuItem[indexPath.row]
                cell.menuPriceLabel.text = self.filteredMenuPrice[indexPath.row]
                cell.menuDescriptionLabel.text = self.filteredMenuDescription[indexPath.row]
            } else {
                cell.menuItemLabel.text = menuItemsSectionedFilter[indexPath.section][indexPath.row]
                cell.menuPriceLabel.text = "$" + menuPricesSectionedFilter[indexPath.section][indexPath.row]
                cell.menuDescriptionLabel.text = menuDescriptionsSectionedFilter[indexPath.section][indexPath.row]
            }
        } else {
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
    
    @IBAction func unwindFilter(_ sender: UIStoryboardSegue) {
        if sender.source is MenuFilterViewController {
            if let filterVC = sender.source as? MenuFilterViewController {
                self.filterSection[0] = filterVC.selectedFilter
                self.filterSectionIndex = filterVC.selectedIndex
            }
        }
    }
    
    @IBAction func undoTapped(_ sender: Any) {
        filterSection[0] = "None"
        filterSectionIndex = -1
        menuTableView.reloadData()
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
