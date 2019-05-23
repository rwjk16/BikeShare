//
//  FavoritesDetailController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-23.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class FavoritesDetailController: UIViewController {
  
  let nameLabel :UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
    label.backgroundColor = .red
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let numberLabel :UILabel = {
    let label = UILabel()
    label.backgroundColor = .blue
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let locationLabel :UILabel = {
    let label = UILabel()
    label.backgroundColor = .black
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let capacityLabel :UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20)
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
      
      self.view.addSubview(stackView)
      
      NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.title = "Station Detail"
  }
    


}
