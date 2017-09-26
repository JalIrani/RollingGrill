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
    
    var detailLabelArray = ["Repeat", "Name", "Sound", "Snooze", "School"]
    var detailDisclosureArray = ["Never", "Alarm", "Marimba", "None", "None"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as UITableViewCell
        //cell.textLabel?.text = detailLabelArray[indexPath.row]
        //cell.detailTextLabel?.text = detailDisclosureArray[indexPath.row]
        return cell
    }

}
