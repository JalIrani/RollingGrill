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
    
    var provolone = false
    var cheddar = false
    var coleslaw = false
    
    let checkedImage = UIImage(named: "checkedBox")! as UIImage
    let uncheckedImage = UIImage(named: "uncheckedBox")! as UIImage
    
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
            let provoloneButton = UIButton(frame: CGRect(x: 16, y: 270, width: 200, height: 40))
            provoloneButton.setImage(uncheckedImage, for: UIControlState.normal)
            provoloneButton.setTitleColor(UIColor.black, for: .normal)
            provoloneButton.setTitle("Provolone (+ $0.50)", for: .normal)
            provoloneButton.addTarget(self, action: #selector(provolonePressed), for: .touchUpInside)
            
            let cheddarButton = UIButton(frame: CGRect(x: 16, y: 300, width: 190, height: 40))
            cheddarButton.setImage(uncheckedImage, for: UIControlState.normal)
            cheddarButton.setTitleColor(UIColor.black, for: .normal)
            cheddarButton.setTitle("Cheddar (+ $0.50)", for: .normal)
            cheddarButton.addTarget(self, action: #selector(cheddarPressed), for: .touchUpInside)
            
            let coleslawButton = UIButton(frame: CGRect(x: 16, y: 330, width: 200, height: 40))
            coleslawButton.setImage(uncheckedImage, for: UIControlState.normal)
            coleslawButton.setTitleColor(UIColor.black, for: .normal)
            coleslawButton.setTitle("Coleslaw (+ $1.00)", for: .normal)
            coleslawButton.addTarget(self, action: #selector(coleslawPressed), for: .touchUpInside)
            
            self.view.addSubview(provoloneButton)
            self.view.addSubview(cheddarButton)
            self.view.addSubview(coleslawButton)
        }
    }
    
    @objc func provolonePressed(sender: UIButton!) {
        if provolone {
            sender.setImage(uncheckedImage, for: UIControlState.normal)
            provolone = false
        } else {
            sender.setImage(checkedImage, for: UIControlState.normal)
            provolone = true
        }
    }
    
    @objc func cheddarPressed(sender: UIButton!) {
        if cheddar {
            sender.setImage(uncheckedImage, for: UIControlState.normal)
            cheddar = false
        } else {
            sender.setImage(checkedImage, for: UIControlState.normal)
            cheddar = true
        }
    }
    
    @objc func coleslawPressed(sender: UIButton!) {
        if coleslaw {
            sender.setImage(uncheckedImage, for: UIControlState.normal)
            coleslaw = false
        } else {
            sender.setImage(checkedImage, for: UIControlState.normal)
            coleslaw = true
        }
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
