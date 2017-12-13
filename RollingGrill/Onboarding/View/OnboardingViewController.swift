//
//  OnboardingViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 12/11/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var completeOnboardingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButtonBorder()
        navBarSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initButtonBorder() {
        completeOnboardingButton.backgroundColor = .clear
        completeOnboardingButton.layer.cornerRadius = 5
        completeOnboardingButton.layer.borderWidth = 1
        completeOnboardingButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func navBarSetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        //UINavigationBar.appearance().barTintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.clear

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
