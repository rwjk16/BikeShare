
//
//  PlansViewController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController{
  
  let tableView : UITableView = {
    let tableView = UITableView()
    tableView.register(PlansCell.self, forCellReuseIdentifier: "customCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .lightGray
    tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    return tableView
  }()
  
  let navigationBar : UINavigationBar = {
    let navBar = UINavigationBar()
    navBar.translatesAutoresizingMaskIntoConstraints = false
    navBar.barTintColor = .white
    let navigationItem = UINavigationItem(title: "Plans")
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancle))
    navigationItem.leftBarButtonItem = cancelButton
    navBar.items = [navigationItem]
    return navBar
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .lightGray
    
    setupView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func setupView(){
    self.view.addSubview(navigationBar)
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
      navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
      navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
      navigationBar.heightAnchor.constraint(equalToConstant: 50),
      
      tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      ])
  }
  
  @objc func handleCancle(){
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension PlansViewController:UITableViewDelegate{
  
}

extension PlansViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PlansCell
    cell.planNameLabel.text = "first plan"
    cell.planDescriptionLabel.text = "description"
    cell.planPriceLabel.text = "$4"
    cell.planImageView.image = UIImage(named: "test")
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //let height = (tableView.frame.height - 60) / 6
    return 142
  }
  
}
