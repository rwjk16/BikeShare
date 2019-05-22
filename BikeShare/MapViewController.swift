//
//  ViewController.swift
//  BikeShare
//
//  Created by Russell Weber on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
  
  let locationManager: CLLocationManager = CLLocationManager()
  var currentLocation: CLLocation = CLLocation()
  
  let refreshButton: Button = Button()
  let favoritesButton: Button = Button()
  let dockToggle: Button = Button()
  
  let mapView: MKMapView = {
      let mapView = MKMapView()
      mapView.mapType = MKMapType.standard
      mapView.isZoomEnabled = true
      mapView.isScrollEnabled = true
      return mapView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    
    if let image = UIImage(named: "refresh") {
      refreshButton.setImage(image, for: .normal)
    }
    
    if let image = UIImage(named: "favorites") {
      favoritesButton.setImage(image, for: .normal)
    }
    
    if let image = UIImage(named: "dockToggle") {
      dockToggle.setImage(image, for: .normal)
    }
    
    refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)

    view.addSubview(mapView)
    self.view.insertSubview(refreshButton, aboveSubview: self.mapView)
    self.view.insertSubview(favoritesButton, aboveSubview: self.mapView)
    self.view.insertSubview(dockToggle, aboveSubview: self.mapView)

    positionRefreshButton()
    positionFavoritesButton()
    positionDockToggleButton()
    mapView.center = self.view.center
    mapView.translatesAutoresizingMaskIntoConstraints = false
    mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: Buttons
  
  func positionFavoritesButton() {
    let x = self.view.frame.maxX * 0.90
    let y = self.view.frame.maxY * 0.82
    favoritesButton.center = CGPoint(x: x, y: y)
  }
  
  func positionRefreshButton() {
    let x = self.view.frame.maxX * 0.90
    let y = self.view.frame.maxY * 0.74
    refreshButton.center = CGPoint(x: x, y: y)
  }
  
  func positionDockToggleButton() {
    let x = self.view.frame.maxX * 0.90
    let y = self.view.frame.maxY * 0.90
    dockToggle.center = CGPoint(x: x, y: y)
  }
  
  @objc func refreshButtonPressed() {
    print("button smashed")
  }

  
  //MARK: Setup Region
  let lat = 0.01
  let lng = 0.01
  
  func setupRegion() {
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: lat, longitudeDelta: lng)
    let region: MKCoordinateRegion = MKCoordinateRegion(center: self.currentLocation.coordinate, span: span)
    self.mapView.setRegion(region, animated: true)
  }

  
  //MARK: CLLocationDelegate Methods
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let currentLocation = locations.first {
      self.currentLocation = currentLocation
    }
    self.mapView.showsUserLocation = true
    setupRegion()
    //fetch bikes w/ location
    //append to array of bike locations
    
  }
}


