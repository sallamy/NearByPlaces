//
//  LocationManager.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject {
    var permission : ((Bool?)->())?
    var didGetLocation: ((CLLocationCoordinate2D) -> ())?

    private var locationManager : CLLocationManager!
    var viewModel: NearByPlacesViewModel?
    init(_ viewModel: NearByPlacesViewModel) {
        super.init()
        self.viewModel  = viewModel
        self.locationManager = CLLocationManager()
        setUpLocationManagerDelegate()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    
    fileprivate func setUpLocationManagerDelegate(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
       locationManager.startUpdatingLocation()
    }
    
    func startUpdate() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.viewModel?.mode == .single {
            manager.stopUpdatingLocation()
            manager.delegate = nil
        }
        if let lat  = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude{
            print("\n\nThe current Lat/Long Is Here\n\n")
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
            self.didGetLocation?(coordinates)
        }else{
            print("Unable To Access Locaion")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            print("Good to go and use location")
            locationManager.startUpdatingLocation()
            self.callPermisssionCompletion(val: true)
            
        case .denied:
            print("DENIED to go and use location")
            self.callPermisssionCompletion(val: false)
            
        case .restricted:
            print("DENIED to go and use location")
            self.callPermisssionCompletion(val: nil)
            
        case .notDetermined:
            print("DENIED to go and use location")
            self.callPermisssionCompletion(val: nil)
            
        default:
            print("Unable to read location :\(status)")
        }
    }
    
    
    fileprivate func callPermisssionCompletion(val : Bool?){
        
        guard let comp = self.permission else {
            print("\n\n Unable to  locate completions \n\n")
            return
        }
        if let val =  val{
            comp(val)
        }
        
    }
}
