//
//  DrinkDetailsViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 12/23/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit

class DrinkDetailsViewController: UIViewController {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var drinkItemLabel: UILabel!
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    
    var drinkItem = String()
    var drinkDescription = String()
    var drinkPrice = String()
    
    var section = -1
    
    var quantity = 0
    
    override func viewDidLoad() {
        setupUI()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drinkItemLabel.text = drinkItem
        drinkDescriptionLabel.text = drinkDescription
        drinkPriceLabel.text = drinkPrice
        print(section)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        if let castedStepper = sender as? UIStepper {
            quantityLabel.text = String(Int(castedStepper.value))
            quantity = Int(castedStepper.value)
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        
        quantityLabel.layer.borderWidth = 1.0
        quantityLabel.layer.borderColor = UIColor.lightGray.cgColor
        quantityLabel.layer.cornerRadius = 5
        
        if section == 0 {
            let button = CheckBox(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
            button.backgroundColor = .green
            button.setTitle("Test Button", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
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
