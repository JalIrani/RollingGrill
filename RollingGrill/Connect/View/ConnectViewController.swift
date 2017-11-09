//
//  ConnectViewController.swift
//  RollingGrill
//
//  Created by Jal Irani on 11/6/17.
//  Copyright © 2017 Apptzr. All rights reserved.
//

import UIKit
import MapKit

class ConnectViewController: UIViewController {

    @IBOutlet weak var whereItAllBegan: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var contactUs: UILabel!
    @IBOutlet weak var ourLocation: UILabel!
    @IBOutlet weak var hoursOfOperation: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = "9533 Belair Rd Nottingham, MD 21236"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)
                
                let point = MKPointAnnotation()
                point.coordinate = mark.coordinate
                point.title = "The Rolling Grill Catering"
                
                if var region = self?.mapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.showAnnotations([point], animated: true)
                }
            }
        }
        whereItAllBegan.textColor = .itemName
        contactUs.textColor = .itemName
        ourLocation.textColor = .itemName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        let websiteURL = URL(string: "https://www.therollinggrillcatering.com/")!
        let application = UIApplication.shared
        if (application.canOpenURL(websiteURL)) {
            application.open(websiteURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func phoneNumberTapped(_ sender: Any) {
        let phoneURL = URL(string: "tel://4103021727")!
        let application = UIApplication.shared
        
        if (application.canOpenURL(phoneURL)) {
            application.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func emailTapped(_ sender: Any) {
        let email = "therollinggrill@gmail.com"
        let emailURL = URL(string: "mailto:\(email)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(emailURL) {
            application.open(emailURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        let screenName =  "thegrill56"
        let appURL = URL(string: "fb://profile/\(screenName)")!
        let webURL = URL(string: "https://facebook.com/\(screenName)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL, options: [:], completionHandler: nil)
        } else {
            application.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        let screenName =  "rollinggrill"
        let appURL = URL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = URL(string: "https://twitter.com/\(screenName)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL, options: [:], completionHandler: nil)
        } else {
            application.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func instagramTapped(_ sender: Any) {
        let userName =  "therollinggrill"
        let appURL = URL(string: "instagram://user?username=\(userName)")!
        let webURL = URL(string: "https://instagram.com/\(userName)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL, options: [:], completionHandler: nil)
        } else {
            application.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func addressTapped(_ sender: Any) {
        let location = "9533 Belair Rd Nottingham, MD 21236"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let placemark = placemarks?.first {
                let mark = MKPlacemark(placemark: placemark)
                let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                let mapItem = MKMapItem(placemark: mark)
                mapItem.openInMaps(launchOptions: options)
            }
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
