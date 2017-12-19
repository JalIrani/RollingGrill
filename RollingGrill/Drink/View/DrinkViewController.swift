//
//  DrinkViewController.swift
//  Admiral's Cup
//
//  Created by Jal Irani on 7/28/17.
//  Copyright © 2017 Jal Irani. All rights reserved.
//

import UIKit
import Stripe

class DrinkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, STPPaymentMethodsViewControllerDelegate {
    
    let customerContext = MockCustomerContext()
    let themeViewController = ThemeViewController()
    
    @IBOutlet weak var drinkTableView: UITableView!
    @IBOutlet weak var shoppingCartButton: UIBarButtonItem!
    
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
    
    var shoppingCart: [String: [String]] = [:]
    
    //var myTuple: [(item: String, price: Double, coleslaw: String, Cheese: String)] = []
    
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
                shoppingCart.removeValue(forKey: cell.drinkItemLabel.text!)
                print(shoppingCart)
            } else {
                cell.drinkItemLabel.textColor = UIColor.red
                cell.drinkPriceLabel.textColor = UIColor.red
                cell.drinkDescriptionLabel.textColor = UIColor.red
                checked[indexPath.section][indexPath.row] = true
                print(cell.drinkItemLabel.text!)
                print(cell.drinkPriceLabel.text!)
                var price = cell.drinkPriceLabel.text!
                price = price.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range:nil)
                shoppingCart[cell.drinkItemLabel.text!] = [price]
                print(shoppingCart)
                if indexPath.section == 0 {
                    createTextFieldPopup(shoppingCartItem: cell.drinkItemLabel.text!)
                } else {
                    shoppingCart[cell.drinkItemLabel.text!] = [price, "none", "none"]
                }
            }
            shoppingCartButton.addBadge(number: shoppingCart.count)
        }
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
    
    func paymentMethodsViewControllerDidCancel(_ paymentMethodsViewController: STPPaymentMethodsViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func paymentMethodsViewControllerDidFinish(_ paymentMethodsViewController: STPPaymentMethodsViewController) {
        //paymentMethodsViewController.navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func paymentMethodsViewController(_ paymentMethodsViewController: STPPaymentMethodsViewController, didFailToLoadWithError error: Error) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkoutTapped(_ sender: Any) {
        if shoppingCart.count == 0 {
            createPopup(popupTitle: "Shopping Cart is Empty", popupMessage: "Please click on a menu item to add it to the shopping cart", actionType: "none", shoppingCartItem: "none", title1: "Cancel", title2: "")
        } else {
            let checkout = printShoppingCartItems()
            createPopup(popupTitle: "Checkout Shopping Cart", popupMessage: checkout.0, actionType: "finished", shoppingCartItem: "none", title1: "Back", title2: "Checkout")
        }
    }
    
    @IBAction func unwindFilterDrink(_ sender: UIStoryboardSegue) {
        if sender.source is DrinkFilterViewController {
            if let filterVC = sender.source as? DrinkFilterViewController {
                self.filterSection[0] = filterVC.selectedFilter
                self.filterSectionIndex = filterVC.selectedIndex
            }
        }
    }
    
    func createPopup(popupTitle: String, popupMessage: String, actionType: String, shoppingCartItem: String, title1: String, title2: String) {
        let alertController = UIAlertController(title: popupTitle, message: popupMessage, preferredStyle: .alert)
        
        
        let noAction = UIAlertAction(title: title1, style: .cancel) { (action:UIAlertAction!) in
        }
        alertController.addAction(noAction)
        
        if actionType != "none" {
            let yesAction = UIAlertAction(title: title2, style: .default) { (action:UIAlertAction!) in
                let theme = self.themeViewController.theme.stpTheme
                let viewController = CardFieldViewController()
                viewController.theme = theme
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.navigationBar.stp_theme = theme
                self.present(navigationController, animated: true, completion: nil)
                //self.performSegue(withIdentifier: "paymentSegue", sender: self)
            }
            alertController.addAction(yesAction)
        }
        //self.present(alertController, animated: true, completion:nil)
        self.present(alertController, animated: true, completion:nil)
        alertController.view.tintColor = UIColor.red
    }
    
    func createTextFieldPopup(shoppingCartItem: String) {
        let alertController1 = UIAlertController(title: "Would you like to add cheese?", message: "Only $0.50 extra", preferredStyle: .alert)
        let alertController2 = UIAlertController(title: "Would you like to add coleslaw?", message: "Only $1.00 extra", preferredStyle: .alert)
        
        let noAction1 = UIAlertAction(title: "None", style: .cancel) { (action:UIAlertAction!) in
            DispatchQueue.main.async() {
                self.shoppingCart[shoppingCartItem]?.append("none")
                print(self.shoppingCart)
                self.present(alertController2, animated: true, completion: nil)
            }
        }
        let provolone1 = UIAlertAction(title: "Provolone", style: .default) { (action:UIAlertAction!) in
            self.shoppingCart[shoppingCartItem]?.append("provolone")
            print(self.shoppingCart)
            DispatchQueue.main.async() {
                self.present(alertController2, animated: true, completion: nil)
            }
        }
        let cheddar1 = UIAlertAction(title: "Cheddar", style: .default) { (action:UIAlertAction!) in
            self.shoppingCart[shoppingCartItem]?.append("cheddar")
            print(self.shoppingCart)
            DispatchQueue.main.async() {
                self.present(alertController2, animated: true, completion: nil)
            }
        }
        
        let noAction2 = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
            print(self.shoppingCart)
            self.shoppingCart[shoppingCartItem]?.append("none")
        }
        let yesAction2 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            print(self.shoppingCart)
            self.shoppingCart[shoppingCartItem]?.append("coleslaw")
        }
        alertController1.addAction(noAction1)
        alertController1.addAction(provolone1)
        alertController1.addAction(cheddar1)
        
        alertController2.addAction(noAction2)
        alertController2.addAction(yesAction2)
        
        self.present(alertController1, animated: true, completion:nil)
        alertController1.view.tintColor = UIColor.red
        alertController2.view.tintColor = UIColor.red
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSectionsDrink" {
            if let secondController = segue.destination as? DrinkFilterViewController {
                print("In prepare for segue \(sections)")
                secondController.sectionsFilter = self.sections
            }
        }
    }
    
    func printShoppingCartItems() -> (String, Double) {
        var checkoutList = ""
        var price = 0.0
        for item in shoppingCart {
            checkoutList += item.key
            price = Double(item.value[0])!
            if item.value[1] != "none" {
                price += 0.50
                checkoutList += " w/ \(item.value[1])"
            }
            if item.value[2] == "coleslaw" {
                price += 1.00
                checkoutList += " w/ \(item.value[2])"
            }
            checkoutList += ": $\(price)\n"
        }
        return (checkoutList, price)
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
