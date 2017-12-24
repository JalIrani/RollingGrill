//
//  ChefMessageViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 12/19/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit

class ChefMessageViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        label.textColor = UIColor.itemName
        textView.layer.borderColor = UIColor.itemName.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
