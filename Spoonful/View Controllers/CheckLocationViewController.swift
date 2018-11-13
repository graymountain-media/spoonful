//
//  CheckLocationViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/8/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CheckLocationViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let rawCoordinates = [[40.758543, -111.852397],[40.767027, -111.852348],[40.767065, -111.847334],[40.768142, -111.847317],[40.769947, -111.847830],[40.770938, -111.847186],[40.771048, -111.843919],[40.771267, -111.843163],[40.772535, -111.842294],[40.772986, -111.841296],[40.773766, -111.836500],[40.766757, -111.827585],[40.764746, -111.830127],[40.757403, -111.818473],[40.757046, -111.821734],[40.754706, -111.821950],[40.754478, -111.823795],[40.752528, -111.823581],[40.752528, -111.825641],[40.750903, -111.825727],[40.751002, -111.837313],[40.753245, -111.837313],[40.753180, -111.842935],[40.754025, -111.842935],[40.754025, -111.847140],[40.758706, -111.847569]]
    var universityCoordinates: [CLLocationCoordinate2D] = []
    var polygonPoints: [CGPoint] = []
    var userLocation: CGPoint?
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
//        view.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7649, longitude: -111.8421), latitudinalMeters: 1500, longitudinalMeters: 2500), animated: false)
        view.setRegion(MKCoordinateRegion(MKMapRect(origin: MKMapPoint(CLLocationCoordinate2D(latitude: 40.777164, longitude: -111.862180)), size: MKMapSize(width: 35000, height: 35000))), animated: false)
        return view
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "We currently only deliver to the University of Utah campus. We will need to verify you're on campus before odering your cereal."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var checkLocationButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Check My Location", for: .normal)
        button.addTarget(self, action: #selector(checkLocationButtonPressed), for: .touchUpInside)
        return button
    }()

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = main
        
        setupViews()
        setMapPolygon()
        setupLocationManager()
        checkLocationAuthorization()
    }
    
    //MARK:- View Setup
    
    private func setupViews() {
        mapView.delegate = self
        
        view.addSubview(mapView)
        view.addSubview(instructionLabel)
        view.addSubview(checkLocationButton)
        
        navigationController?.isNavigationBarHidden = false
        self.title = "Verify Location"
        
        instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        instructionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        checkLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        checkLocationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkLocationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        checkLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        mapView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: checkLocationButton.topAnchor, constant: -16).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setMapPolygon(){
        for coordinate in rawCoordinates {
            let new2DCoordinate = CLLocationCoordinate2D(latitude: coordinate[0], longitude: coordinate[1])
            let newCGPoint = CGPoint(x: coordinate[0], y: coordinate[1])
            universityCoordinates.append(new2DCoordinate)
            polygonPoints.append(newCGPoint)
        }
        let polygon = MKPolygon(coordinates: universityCoordinates, count: universityCoordinates.count)
        mapView.addOverlay(polygon)
    }
    
    //MARK:- Location Manager and Location Services
    
    private func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Location Services have are not enabled on this device. Please go to Settings > Privacy > Location Services to enable Location Services.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            present(alert, animated: true, completion: nil)
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
            
            present(alert, animated: true, completion: nil)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            let alert = UIAlertController(title: "Location Services Restricted", message: "Loaction Services have been restricted on this device, and must be enabled before using Spoonful.", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            present(alert, animated: true, completion: nil)
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    func boundariesContain(point: CGPoint) -> Bool {
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
    
    //MARK:- Button Action
    
    @objc private func checkLocationButtonPressed(){
        
        if let userLocation = userLocation {
            if boundariesContain(point: userLocation) {
                navigationController?.pushViewController(NewOrderViewController(), animated: true)
            } else {
                let alert = UIAlertController(title: "Cannot Deliver to Your Location", message: "We're sorry, we are currently only delivering to the University of Utah campus", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "Okay", style: .cancel) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okayAction)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }

}

extension CheckLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.25)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 1
        return renderer
    }
}

extension CheckLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let point = CGPoint(x: locations[0].coordinate.latitude, y: locations[0].coordinate.longitude)
        
        userLocation = point
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
