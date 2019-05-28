//
//  StationDetailModalView.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-28.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class StationDetailModalView: UIView {
  
  let stationNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18)
    label.numberOfLines = 0
    label.backgroundColor = .white
    label.textAlignment = .center
    return label
  }()
  
  let numOfBikesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 30)
    label.numberOfLines = 0
    label.backgroundColor = .white
    label.textAlignment = .center
    return label
  }()
  
  let numOfDocksLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 30)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.backgroundColor = .white
    return label
  }()
  
  let directionButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Plan a ride", for: .normal)
    button.backgroundColor = .blue
    button.clipsToBounds = true
    button.layer.cornerRadius = 30
    return button
  }()
  
  let favoriteButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("fav", for: .normal)
    button.backgroundColor = .yellow
    button.clipsToBounds = true
    button.layer.cornerRadius = 20
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.clipsToBounds = true
    self.layer.cornerRadius = 20
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
    self.layer.masksToBounds = false
    self.layer.shadowRadius = 5.0
    self.layer.shadowOpacity = 0.75
    self.addSubview(favoriteButton)
    self.addSubview(stationNameLabel)
    self.addSubview(numOfBikesLabel)
    self.addSubview(numOfDocksLabel)
    self.addSubview(directionButton)
    
    NSLayoutConstraint.activate([
      stationNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      stationNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
      stationNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
      stationNameLabel.heightAnchor.constraint(equalToConstant: 50),
      
      numOfBikesLabel.topAnchor.constraint(equalTo: stationNameLabel.bottomAnchor, constant: 10),
      numOfBikesLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -80),
      numOfBikesLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
      numOfBikesLabel.heightAnchor.constraint(equalToConstant: 70),
      
      numOfDocksLabel.topAnchor.constraint(equalTo: stationNameLabel.bottomAnchor, constant: 10),
      numOfDocksLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
      numOfDocksLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: 80),
      numOfDocksLabel.heightAnchor.constraint(equalToConstant: 70),
      
      directionButton.topAnchor.constraint(equalTo: numOfDocksLabel.bottomAnchor, constant: 20),
      directionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
      directionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
      directionButton.heightAnchor.constraint(equalToConstant: 60),
      directionButton.widthAnchor.constraint(equalToConstant: 60),
      
      favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      favoriteButton.heightAnchor.constraint(equalToConstant: 40),
      favoriteButton.widthAnchor.constraint(equalToConstant: 40),
      ])
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
