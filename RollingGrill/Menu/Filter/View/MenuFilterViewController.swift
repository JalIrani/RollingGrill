//
//  MenuFilterViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 11/6/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit

class MenuFilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var sectionsFilter = [String]()
    var selectedFilter = "None"
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as UITableViewCell
        print(sectionsFilter[indexPath.row])
        cell.textLabel?.text = sectionsFilter[indexPath.row]
        if (indexPath.row == selectedIndex) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            print("Row we checked: \(indexPath.row)")
            if cell.accessoryType == .checkmark {
                selectedFilter = "None"
                selectedIndex = -1
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
                selectedFilter = sectionsFilter[indexPath.row]
                selectedIndex = indexPath.row
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */
}
