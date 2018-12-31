//
//  CheckLocationManager.swift
//  Spoonful
//
//  Created by Jake Gray on 12/21/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol CheckUserDelegate: class {
    func presentAlert(_ alert: UIAlertController)
}

protocol LocationAuthorizationDelegate: class {
    func presentAlert(_ alert: UIAlertController)
}

class CheckLocationManager: NSObject {
    
    static let shared = CheckLocationManager()
    
    let locationManager = CLLocationManager()
    let rawCoordinates = [[40.758543, -111.852397],[40.767027, -111.852348],[40.767065, -111.847334],[40.768142, -111.847317],[40.769947, -111.847830],[40.770938, -111.847186],[40.771048, -111.843919],[40.771267, -111.843163],[40.772535, -111.842294],[40.772986, -111.841296],[40.773766, -111.836500],[40.766757, -111.827585],[40.764746, -111.830127],[40.757403, -111.818473],[40.757046, -111.821734],[40.754706, -111.821950],[40.754478, -111.823795],[40.752528, -111.823581],[40.752528, -111.825641],[40.750903, -111.825727],[40.751002, -111.837313],[40.753245, -111.837313],[40.753180, -111.842935],[40.754025, -111.842935],[40.754025, -111.847140],[40.758706, -111.847569]]
    var universityCoordinates: [CLLocationCoordinate2D] = []
    var polygonPoints: [CGPoint] = []
    var userLocation: CGPoint?
    let testUserLocation = CGPoint(x: 40.767344, y: -111.840000)
    
    weak var checkUserLocationDelegate: CheckUserDelegate?
    weak var locationAuthorizationDelegate: LocationAuthorizationDelegate?
    
    
    override init() {
        super.init()
        setPolygon()
        setupLocationManager()
    }
    
    //MARK:- View Setup
    
    
    private func setPolygon(){
        for coordinate in rawCoordinates {
            let new2DCoordinate = CLLocationCoordinate2D(latitude: coordinate[0], longitude: coordinate[1])
            let newCGPoint = CGPoint(x: coordinate[0], y: coordinate[1])
            universityCoordinates.append(new2DCoordinate)
            polygonPoints.append(newCGPoint)
        }
    }
    
    //MARK:- Location Manager and Location Services
    
    private func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Location Services have are not enabled on this device. Please go to Settings > Privacy > Location Services to enable Location Services.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            locationAuthorizationDelegate?.presentAlert(alert)
        }
    }
    
    private func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            let alert = UIAlertController(title: "Location Services Denied", message: "To be able to take your order, we must ensure you are on campus. Please go to Settings > Privacy > Location Services to enable Location Services for Spoonful.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            locationAuthorizationDelegate?.presentAlert(alert)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            let alert = UIAlertController(title: "Location Services Restricted", message: "Loaction Services have been restricted on this device, and must be enabled before using Spoonful.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            locationAuthorizationDelegate?.presentAlert(alert)
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    private func boundariesContain(point: CGPoint) -> Bool {
        let path = UIBezierPath()
        let firstPoint = polygonPoints[0] as CGPoint
        
        path.move(to: firstPoint)
        
        for index in 1...polygonPoints.count-1 {
            path.addLine(to: polygonPoints[index] as CGPoint)
        }
        
        path.close()
        print("Contains: \(path.contains(point))")
        return path.contains(point)
    }
    
    func checkUserLocation() -> Bool {
        if let userLocation = userLocation {
            if boundariesContain(point: userLocation) {
                print("user in location")
                return true
            } else {
                let alert = UIAlertController(title: "Cannot Deliver to Your Location", message: "We're sorry, we are currently only delivering to the University of Utah campus", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "Okay", style: .cancel) { (_) in
                    
                    print("User not in location")
                }
                alert.addAction(okayAction)
                checkUserLocationDelegate?.presentAlert(alert)
                return false
            }
        } else {
            print("could not get user location")
            return false
        }
    }
    
}

extension CheckLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let point = CGPoint(x: locations[0].coordinate.latitude, y: locations[0].coordinate.longitude)
        
        userLocation = point
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

