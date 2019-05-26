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
  
  var favoriteStations = [MKAnnotation]()
  var stations = [MKAnnotation]()
  var stationStatus = [stationStatusStruct]()
  let locationManager: CLLocationManager = CLLocationManager()
  var currentLocation: CLLocation = CLLocation()
  var stationSelected : Station?
  let manager = StationManager()
  
  let refreshButton: RefreshButton = RefreshButton()
  let favoritesButton: Button = Button()
  let dockToggle: Button = Button()
  let backButton: Button = Button()
  let centerButton : Button = Button()
  
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
    self.mapView.delegate = self
    
    mapView.delegate = self
    
    setupViews()
    fetchBikeStations()
    fetchStationStatus()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.navigationBar.isHidden = true
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    mapView.addGestureRecognizer(tapGesture)
  }
  
  
  func fetchBikeStations(){
    manager.fetchBikeStation(userLocation: currentLocation.coordinate, searchTerm: nil) { stations in
      guard let stations = stations else {return}
      
      self.stations = stations
      self.mapView.addAnnotations(self.stations)
      self.mapView.showAnnotations(self.stations, animated: true)
      self.locationManager.stopUpdatingLocation()
    }
  }
  
  func fetchStationStatus(){
    manager.fetchStationStatusStruct { (statuses) in
      self.stationStatus = statuses
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
    positionCenterButton()
  }
  
  func setupStationView(){
    stationDetailView.isHidden = true
    stationDetailView.backgroundColor = .white
    self.view.addSubview(stationDetailView)
    stationDetailView.favoriteButton.addTarget(self, action: #selector(handleFav), for: .touchUpInside)
    stationDetailView.directionButton.addTarget(self, action: #selector(handleDirection), for: .touchUpInside)
    
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
  
  func positionCenterButton(){
    let x = self.view.frame.maxX * 0.10
    let y = self.view.frame.maxY * 0.90
    centerButton.center = CGPoint(x: x, y: y)
  }
  
  func setupButtonImages() {
    self.view.insertSubview(refreshButton, aboveSubview: self.mapView)
    self.view.insertSubview(favoritesButton, aboveSubview: self.mapView)
    self.view.insertSubview(dockToggle, aboveSubview: self.mapView)
    self.view.insertSubview(backButton, aboveSubview: self.mapView)
    self.view.insertSubview(centerButton, aboveSubview: self.mapView)
    
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
    
    centerButton.setImage(UIImage(named: "compass"), for: .normal)
    centerButton.addTarget(self, action: #selector(handleCenter), for: .touchUpInside)
  }
  
  @objc func refreshButtonPressed() {
    //TODO: handle refresh
    refreshButton.rotateImage()
    fetchStationStatus()
  }
  
  @objc func favoritesButtonPressed() {
    let favoritesView = FavoritesViewController()
    favoritesView.favoriteStations = self.favoriteStations as! [Station]
    self.navigationController?.pushViewController(favoritesView, animated: true)
  }
  
  @objc func dockToggleButtonPressed() {
    //TODO: annotation/view switch from bike to dock
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
      
      
      for station in self.stations {
        
        for (i, favoritedStation) in self.favoriteStations.enumerated() {
          if favoritedStation.title == self.stationDetailView.stationNameLabel.text {
            self.favoriteStations.remove(at: i)
            return
          }
        }
        
        if let title = station.title {
          if title == self.stationDetailView.stationNameLabel.text {
            self.favoriteStations.append(station)
            return
          }
        }
      }
    }
  }
  
  @objc func handleDirection(){
    guard let coordinate = stationSelected?.coordinate else {return}
    let regionDistance = 1000.0
    let regionSpan = MKCoordinateRegion(center: coordinate,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
    let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
    
    let placeMark = MKPlacemark(coordinate: coordinate)
    let mapItem = MKMapItem(placemark: placeMark)
    mapItem.name = stationSelected?.address
    mapItem.openInMaps(launchOptions: options)
  }
  
  @objc func handleCenter(){
   locationManager.startUpdatingLocation()
    mapView.centerCoordinate = currentLocation.coordinate
    setupRegion()
    locationManager.stopUpdatingLocation()
  }
}
  
  extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
      var numBikes = ""
      var numDocks = ""
      if let annotation = view.annotation as? Station{
        self.stationSelected = annotation
        let id = annotation.station_id
        for station in self.stationStatus{
          if station.station_id == id{
            numBikes = String(station.num_bikes_available)
            numDocks = String(station.num_docks_available)
          }
        }
        let bikesText = NSMutableAttributedString(string: numBikes, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 35)])
        
        bikesText.append(NSAttributedString(string: "\nBikes", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        
        let docksText = NSMutableAttributedString(string: numDocks, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 35)])
        docksText.append(NSAttributedString(string: "\nDocks", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        if view.annotation is MKUserLocation{
          return
        }
        
        self.stationDetailView.numOfBikesLabel.attributedText = bikesText
        self.stationDetailView.numOfDocksLabel.attributedText = docksText
        self.stationDetailView.stationNameLabel.text = annotation.name
        
      }
      
      UIView.transition(with: stationDetailView, duration: 0.3, options: .transitionCrossDissolve, animations: {
        self.stationDetailView.isHidden = false
      }, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
      if (annotation is MKUserLocation) {
        return nil
      }
      
      let annotationIdentifier = "AnnotationIdentifier"
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
      
      if annotationView == nil {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        annotationView!.canShowCallout = true
      }
      else {
        annotationView!.annotation = annotation
      }
      
      let pinImage = UIImage(named: "infoPin")
      annotationView!.image = pinImage
      annotationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.07, height: self.view.frame.size.width * 0.07)
      return annotationView
    }
}


