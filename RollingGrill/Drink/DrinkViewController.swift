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
    
    var drinkItemArray = ["this is the longest drink name of all time so im gonna see where it goes", "Heiniken", "Sangria", "Coor Lite", "Miller Lite"]
    var drinkPriceArray = ["12.99", "4.99", "7.50", "1.50", "2.25"]
    var drinkDescriptionArray = ["This is mixed with all of your favorite tequila including don julio and patron coffee", "its beer", "its soft", "its beer", "i love miller lite"]
    
    // RGB values for Big text: R:117 G:111 B:99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkTableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkTableViewCell
        cell.drinkItemLabel.text = drinkItemArray[indexPath.row]
        cell.drinkPriceLabel.text = "$" + drinkPriceArray[indexPath.row]
        cell.drinkDescriptionLabel.text = drinkDescriptionArray[indexPath.row]
        
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
