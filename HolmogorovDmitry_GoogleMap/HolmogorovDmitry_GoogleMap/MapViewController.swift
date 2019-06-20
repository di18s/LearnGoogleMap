//
//  ViewController.swift
//  HolmogorovDmitry_GoogleMap
//
//  Created by Дмитрий on 20/06/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var mapView: GMSMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.configureLocationManager()
        self.addUI()
        self.configureMap()
        
        
    
    }
    private func addUI() {
        self.mapView = GMSMapView(frame: self.view.bounds)
        self.view.addSubview(self.mapView)
        
        let rightBarBtn = UIBarButtonItem(title: "Current", style: .done, target: self, action: #selector(current))
        let leftBarBtn = UIBarButtonItem(title: "Move", style: .done, target: self, action: #selector(movePosition))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationItem.leftBarButtonItem = leftBarBtn
        

    }
    @objc
    func current() {
        locationManager?.requestLocation()
        
    }
    @objc
    func movePosition() {
        locationManager?.startUpdatingLocation()
    }
    private func configureMap() {
        let coordinate = CLLocationCoordinate2D(latitude: 56.84976, longitude: 53.20448)
        // Создаём камеру с использованием координат и уровнем увеличения
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        // Устанавливаем камеру для карты
        self.mapView.camera = camera
        self.mapView.animate(toLocation: coordinate)
        
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(named: "marker")
        marker.map = mapView
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
    }
}

//MARK: CLLocationManagerDelegate
extension MapViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else {fatalError()}
        
        print(coordinate)
        
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        self.mapView.camera = camera
        self.mapView.animate(toLocation: coordinate)
        
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(named: "marker")
        marker.map = self.mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
