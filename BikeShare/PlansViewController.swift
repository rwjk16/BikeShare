
//
//  PlansViewController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController{
  
  let manager = StationManager()
  let descriptions = ["Ride a TIXIE for a trip on the fly",
                      "Get access to the TIXIE system for a 24h period",
                      "Get access to the TIXIE system for a 72h period",
                      "Use your Presto Pass to get access to the TIXIE system for one year",
                      "Get TIXIE for Toronto and enjoy your access to the system for one year",
                      "Get TIXIE for available cities and get access to the system for one year",
                      ]
  
  var pricePlans = [Plan]()
  
  let tableView : UITableView = {
    let tableView = UITableView()
    tableView.register(PlansCell.self, forCellReuseIdentifier: "customCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = UIColor(red: 0/255, green: 181.0/255, blue: 204.0/255, alpha: 1.0)
    tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(red: 0/255, green: 181.0/255, blue: 204.0/255, alpha: 1.0)
    setupView()
    
    manager.fetchPricePlan { (plans) in
      var plan = plans
      plan.swapAt(0, 5)
      self.pricePlans = plan
      self.tableView.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.title = "Pricing Plans"
  }
  
  func setupView(){
    //self.view.addSubview(navigationBar)
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
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
    return pricePlans.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PlansCell
    let plan = pricePlans[indexPath.row]
    cell.planNameLabel.text = plan.name
    
    var description: String
    switch plan.price {
    case "3.25":
      description = descriptions[0]
    case "7.00":
      description = descriptions[1]
    case "15.00":
      description = descriptions[2]
    case "69.30":
      description = descriptions[3]
    case "90.00":
      description = descriptions[4]
    case "99.00":
      description = descriptions[5]
    default:
      description = "YOU ARE VIP, RIDE FOR FREE"
    }
    cell.planDescriptionLabel.text = description
    cell.planPriceLabel.text = ("$\(plan.price)")
    cell.planImageView.image = UIImage(named: "test")
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //let height = (tableView.frame.height - 60) / 6
    return 152
  }
  
}
