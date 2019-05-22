//
//  ViewController.swift
//  BikeShare
//
//  Created by Russell Weber on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let url = URL(string: "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information")
    let decoderJSON = JSONDecoder()
    let info = try! decoderJSON.decode(Json.self, from: Data(contentsOf: url!))
    let data = info.data
    let stations = data.stations

    //print(stations![0])
    var arrayStations: [Station] = []

    guard let s = stations else {
        return
    }
    for station in  s {
        arrayStations.append(station)
  print("\(station.name) - \(station.address)  - \(station.rental_methods)")

    }
    print(arrayStations[0].name)
//    let data = info["data"]
  }


}

