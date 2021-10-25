//
//  ViewController.swift
//  detectLocation
//
//  Created by ahmed on 25/10/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var name: String = "aaaa"
    var locationManger : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        locationManger = CLLocationManager()
        locationManger.delegate = self
    }
    
    
    @IBAction func detectLocationClicked(_ sender: Any) {
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestAlwaysAuthorization()
    
    if CLLocationManager.locationServicesEnabled(){
        print("location enabled")
        locationManger.startUpdatingLocation()
    
    }else{
        print("location disable")
    }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0] as CLLocation
        //print("local manger function here")
        let latitude = userLocation.coordinate.latitude
        let longtitude = userLocation.coordinate.longitude
        
        latitudeLabel.text = "latitude :   \(latitude)"
        longtitudeLabel.text = "longtitude :  \(longtitude)"
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation){
         (placemarks,error) in
            if(error != nil)
            {
                print("error in reverse  !!!!!!")
            }
            let placemark = placemarks! as [CLPlacemark]
            if (placemark.count > 0)
            {
                let placemark = placemarks![0]
                let locality =  placemark.locality ?? ""
                let administrativeArea = placemark.administrativeArea ?? ""
                let country = placemark.country ?? ""
                
              //  print("address")
                self.addressLabel.text = "Address : \(locality), \(administrativeArea) ,\(country)"
            }
        }
    }

    }

