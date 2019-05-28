//
//  ViewController.swift
//  BikeShare
//
//  Created by Russell Weber on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class MapViewController: UIViewController, CLLocationManagerDelegate{
  
  var stations = [MKAnnotation]()
  let locationManager: CLLocationManager = CLLocationManager()
  var currentLocation: CLLocation = CLLocation()
  
  let refreshButton: RefreshButton = RefreshButton()
  let favoritesButton: Button = Button()
  let dockToggle: Button = Button()
  let backButton: Button = Button()
  
  let stationDetailView = StationDetailModalView()
  
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
    
    mapView.delegate = self
    
    setupViews()
    setupManager()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.navigationBar.isHidden = true
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    mapView.addGestureRecognizer(tapGesture)
  }
  
  
  func setupManager(){
    let manager = StationManager()
    manager.fetchBikeStation(userLocation: currentLocation.coordinate) { stations in
      guard let stations = stations else {return}
      
      self.stations = stations
      self.mapView.addAnnotations(self.stations)
      self.mapView.showAnnotations(self.stations, animated: true)
    }
  }
  
  func setupViews(){
    constrainMapView()
    setupButtonImages()
    positionButtons()
    setupStationView()
  }
  
  //MARK: Buttons
  func positionButtons(){
    positionRefreshButton()
    positionFavoritesButton()
    positionDockToggleButton()
    positionBackButton()
  }
  
  func setupStationView(){
    stationDetailView.isHidden = true
    stationDetailView.backgroundColor = .white
    self.view.addSubview(stationDetailView)
    stationDetailView.favoriteButton.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      stationDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      stationDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      stationDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      ])
  }
  
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

  func setupRegion() {
    let lat = 0.01
    let lng = 0.01
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
  }
  
  @objc func handleTap(){
    stationDetailView.isHidden = true
  }
  
  @objc func handleFav(){
    SVProgressHUD.show(withStatus: "Saving Fav")
    
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (nil) in
      SVProgressHUD.dismiss()
    }
  }
}
  
  extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
      
      let bikesText = NSMutableAttributedString(string: "1", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 35)])
      bikesText.append(NSAttributedString(string: "\nBikes", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
      
      let docksText = NSMutableAttributedString(string: "2", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 35)])
      docksText.append(NSAttributedString(string: "\nDocks", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
      
      if let annotation = view.annotation as? Station{
        self.stationDetailView.numOfBikesLabel.attributedText = bikesText
        self.stationDetailView.numOfDocksLabel.attributedText = docksText
        self.stationDetailView.stationNameLabel.text = annotation.name
      }
      
      UIView.transition(with: stationDetailView, duration: 0.3, options: .transitionCrossDissolve, animations: {
        self.stationDetailView.isHidden = false
      }, completion: nil)
    }
}


