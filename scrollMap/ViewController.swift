//
//  ViewController.swift
//  scrollMap
//
//  Created by Arash on 6/12/16.
//  Copyright © 2016 Arash. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var scrollView: CXScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpScrollView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bringSubviewToFront(self.scrollView)
    }
    
    private func setUpScrollView() {
        // Setup the buttons
        // The size and position are set in the scrollView, do not change it directly from here
        self.scrollView.firstButton.setTitle("Arrive", forState: .Normal)
        self.scrollView.firstButton.backgroundColor = UIColor.colorWithHexString("57b560")
        self.scrollView.firstButton.addTarget(self, action: #selector(self.buttonAction(_:)), forControlEvents: .TouchUpInside)
        
        self.scrollView.secondButton.setTitle("Delay", forState: .Normal)
        self.scrollView.secondButton.backgroundColor = UIColor.colorWithHexString("e1b227")
        self.scrollView.secondButton.addTarget(self, action: #selector(self.buttonAction(_:)), forControlEvents: .TouchUpInside)
        
        self.scrollView.thirdButton.setTitle("Cancel", forState: .Normal)
        self.scrollView.thirdButton.backgroundColor = UIColor.colorWithHexString("c84738")
        self.scrollView.thirdButton.addTarget(self, action: #selector(self.buttonAction(_:)), forControlEvents: .TouchUpInside)
    }
    
    // Mark: - Actions
    func buttonAction(button: UIButton) {
        switch button {
        case self.scrollView.firstButton:
            // do something after user press first button
            break
        case self.scrollView.secondButton:
            // do something after user press secondButton button
            break
        case self.scrollView.thirdButton:
            // do something after user press thirdButton button
            break
        default:
            break
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            
        }
    }
}





