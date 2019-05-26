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
  
  let refreshButton: RefreshButton = RefreshButton()
  let favoritesButton: Button = Button()
  let dockToggle: Button = Button()
  let backButton: Button = Button()
  
  var dockToggled = false
  
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
    manager.fetchBikeStation(userLocation: currentLocation.coordinate, searchTerm: nil) { stations in
      guard let stations = stations else {return}
      
      self.stations = stations
      self.mapView.addAnnotations(self.stations)
      self.mapView.showAnnotations(self.stations, animated: true)
      self.locationManager.stopUpdatingLocation()
    }
    
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
    refreshButton.rotateImage()
    self.locationManager.startUpdatingLocation()
    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
      self.locationManager.stopUpdatingLocation()
    }
  }
  
  @objc func favoritesButtonPressed() {
    let favoritesView = FavoritesViewController()
    favoritesView.favoriteStations = self.favoriteStations as! [Station]
    self.navigationController?.pushViewController(favoritesView, animated: true)
  }
  
  @objc func dockToggleButtonPressed() {
    //TODO: annotation/view switch from bike to dock
    self.dockToggled = !self.dockToggled
    self.mapView.removeAnnotations(self.mapView.annotations)
    self.mapView.addAnnotations(self.stations)
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
}

extension MapViewController:MKMapViewDelegate{
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    var numBikes = ""
    var numDocks = ""
    if let annotation = view.annotation as? Station{
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
    
    var pinImage = UIImage(named: "infoPin")
    if let annotation = annotation as? Station{
      let id = annotation.station_id
      for station in self.stationStatus{
        if station.station_id == id{
          if !self.dockToggled {
            let numBikes = station.num_bikes_available
            switch numBikes{
            case 15...99:
              pinImage = UIImage(named: "bikeFull")
            case 3..<15:
              pinImage = UIImage(named: "bikeMedium")
            case 0..<3:
              pinImage = UIImage(named: "bikeEmpty")
            default:
              pinImage = UIImage(named: "infoPin")
          }

          } else {
            let numDocks = station.num_docks_available
            switch numDocks{
            case 15...99:
              pinImage = UIImage(named: "dockFull")
            case 3..<15:
              pinImage = UIImage(named: "dockMedium")
            case 0..<3:
              pinImage = UIImage(named: "dockEmpty")
            default:
              pinImage = UIImage(named: "infoPin")
            
          }
          }
        }
      }
    }
        
        annotationView!.image = pinImage
        annotationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.07, height: self.view.frame.size.width * 0.07)
        return annotationView
      }
}


