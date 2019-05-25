//
//  FavoritesViewController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-23.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  var favoriteStations = [Station()]
  
  let favoritesTableView : UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(FavoritesCell.self, forCellReuseIdentifier: "customCell")
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.title = "Favorites"
    self.favoritesTableView.reloadData()
  }
  
  func setupViews(){
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    print(statusBarHeight)
    self.view.backgroundColor = .white
    self.view.addSubview(favoritesTableView)
    favoritesTableView.delegate = self
    favoritesTableView.dataSource = self
    
    NSLayoutConstraint.activate([
      favoritesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
      favoritesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      favoritesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      favoritesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      ])
  }
  
  @objc func handleCancle(){
    self.dismiss(animated: true, completion: nil)
  }

}

extension FavoritesViewController:UITableViewDelegate{
  
}

extension FavoritesViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.favoriteStations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FavoritesCell
    cell.textLabel?.text = self.favoriteStations[indexPath.row].title
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected roll")
    let detailViewController = FavoritesDetailController()
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
  
  
}
