//
//  MainMenuViewController.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import MapKit

final class MainMenuViewController: UIViewController {

    var stations : [MKAnnotation] = [] {
        didSet{

            print("\(self) - \(#function) - \(String(describing: (stations[0] as! Station).status))")
        }
    }
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let logoView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Tixie")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let plansButton: UIButton = {
        let button = UIButton()
        button.setTitle("VIEW PRICING DETAIL", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handlePlans), for: .touchUpInside)
        return button
    }()

    let showMapButton : UIButton = {
        let button = UIButton()
        button.setTitle("SHOW MAP", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleShowMap), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let navi = navigationController else { return }
        navi.navigationBar.isHidden = true
        navi.navigationBar.barTintColor = UIColor(red: 0/255, green: 181.0/255, blue: 204.0/255, alpha: 1.0)
        navi.navigationBar.tintColor = UIColor.white
        navi.navigationBar.setValue(true, forKey: "hidesShadow")
        navi.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font:UIFont.boldSystemFont(ofSize: 18)]
    }

    func setupViews() {
        containerView.addSubview(imageView)
        containerView.addSubview(plansButton)
        containerView.addSubview(showMapButton)
        containerView.addSubview(logoView)
        self.view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),

            logoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            logoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            logoView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0),

            plansButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            plansButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            plansButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0),
            plansButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 170),
            plansButton.heightAnchor.constraint(equalToConstant: 55),

            showMapButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            showMapButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            showMapButton.topAnchor.constraint(equalTo: plansButton.bottomAnchor, constant: 8),
            showMapButton.heightAnchor.constraint(equalToConstant: 55),
            ])
    }

    @objc func handlePlans() {
        let plansViewController = PlansViewController()
        self.navigationController?.pushViewController(plansViewController, animated: true)
    }

    @objc func handleShowMap() {
        let mapviewController = MapViewController()
        mapviewController.stations = self.stations
        self.navigationController?.pushViewController(mapviewController, animated: true)
    }


}
