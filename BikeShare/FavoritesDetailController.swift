//
//  FavoritesDetailController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-23.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import CoreLocation

class FavoritesDetailController: UIViewController {
  
  var station = Station()
  var address = ""

  let nameLabel :UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.backgroundColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let numberLabel :UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let locationLabel :UILabel = {
    let label = UILabel()
    label.backgroundColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let capacityLabel :UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.backgroundColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var stackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: [nameLabel,locationLabel,capacityLabel,numberLabel])
    sv.backgroundColor = .red
    sv.distribution = .fillEqually
    sv.axis = .vertical
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      ])
    
    reverseGeocode()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.title = "Station Detail"
    setupLabels()
  }
  
  func setupLabels(){
    let nameText = NSMutableAttributedString(string: "Name: ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
    nameText.append(NSAttributedString(string: station.name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.black]))
    
    let numberText = NSMutableAttributedString(string: "Number: ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
    numberText.append(NSAttributedString(string: station.obcn, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.black]))
    
    let capacityText = NSMutableAttributedString(string: "Capacity: ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
    capacityText.append(NSAttributedString(string: String(station.capacity), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.black]))
    
    nameLabel.attributedText = nameText
    numberLabel.attributedText = numberText
    capacityLabel.attributedText = capacityText
  }
  
  func reverseGeocode(){
    numberLabel.isHidden = true
    nameLabel.isHidden = true
    locationLabel.isHidden = true
    capacityLabel.isHidden = true
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: station.lat, longitude: station.lon)
   
    geoCoder.reverseGeocodeLocation(location) { (placementMarkArray, error) in
      if(placementMarkArray?.count)! > 0 {
        
         let locationText = NSMutableAttributedString(string: "Location: ", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        
        guard let placemark = placementMarkArray?.first else{return}
        guard let number = placemark.subThoroughfare else {return}
        guard let bairro = placemark.subLocality else{return}
        guard let street = placemark.thoroughfare else{return}
    
        let address = "\(number) \(street) - \(bairro)"
       
        locationText.append(NSAttributedString(string: address, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.black]))
        self.locationLabel.attributedText = locationText
        self.numberLabel.isHidden = false
        self.nameLabel.isHidden = false
        self.locationLabel.isHidden = false
        self.capacityLabel.isHidden = false
      }
    }
  }
}
