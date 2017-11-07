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
                    //self?.mapView.addAnnotation(mark)
                    self?.mapView.showAnnotations([point], animated: true)
                }
//                let mapItem = MKMapItem(placemark: mark)
//                mapItem.openInMaps(launchOptions: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
