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
  
  var stations = [MKAnnotation]()
  let locationManager: CLLocationManager = CLLocationManager()
  var currentLocation: CLLocation = CLLocation()
  
  let refreshButton: RefreshButton = RefreshButton()
  let favoritesButton: Button = Button()
  let dockToggle: Button = Button()
  let backButton: Button = Button()
  
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
    
    constrainMapView()
    setupButtonImages()
    
    positionRefreshButton()
    positionFavoritesButton()
    positionDockToggleButton()
    positionBackButton()
    
    print(refreshButton.frame)
    
    let manager = StationManager()
    manager.fetchBikeStation(userLocation: currentLocation.coordinate) { stations in
      guard let stations = stations else {return}
      print(stations)
      
      self.stations = stations
      self.mapView.addAnnotations(self.stations)
      self.mapView.showAnnotations(self.stations, animated: true)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.navigationBar.isHidden = true
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
  
  func positionBackButton() {
    let x = self.view.frame.maxX * 0.10
    let y = self.view.frame.maxY * 0.10
    backButton.center = CGPoint(x: x, y: y)
  }
  
  func setupButtonImages() {
    
    self.view.insertSubview(refreshButton, aboveSubview: self.mapView)
    self.view.insertSubview(favoritesButton, aboveSubview: self.mapView)
    self.view.insertSubview(dockToggle, aboveSubview: self.mapView)
    self.view.insertSubview(backButton, aboveSubview: self.mapView)
    
    if let image = UIImage(named: "refresh") {
      refreshButton.setImage(image, for: .normal)
    }
    refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
    
    if let image = UIImage(named: "favorites") {
      favoritesButton.setImage(image, for: .normal)
    }
    favoritesButton.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
    
    if let image = UIImage(named: "dockToggle") {
      dockToggle.setImage(image, for: .normal)
    }
    dockToggle.addTarget(self, action: #selector(dockToggleButtonPressed), for: .touchUpInside)
    
    if let image = UIImage(named: "back") {
      backButton.setImage(image, for: .normal)
    }
    backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
  }
  
  @objc func refreshButtonPressed() {
    //TODO: handle refresh
    refreshButton.rotateImageThenShowLoading()
    print("button smashed")
  }
  
  
  @objc func favoritesButtonPressed() {
    let favoritesView = FavoritesViewController()
    self.navigationController?.pushViewController(favoritesView, animated: true)
  }
  
  @objc func dockToggleButtonPressed() {
    //TODO: annotation/view switch from bike to dock
    print("button smashed")
  }
  
  @objc func backButtonPressed() {
    self.navigationController?.popViewController(animated: true)
  }
  
  //MARK: Setup Region & constrain mapview
  
  func constrainMapView() {
    view.addSubview(mapView)
    mapView.center = self.view.center
    mapView.translatesAutoresizingMaskIntoConstraints = false
    mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
  }
  
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



