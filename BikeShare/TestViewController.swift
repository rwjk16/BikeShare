//
//  TestViewController.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information")
        let decoderJSON = JSONDecoder()
        let JSON = try! decoderJSON.decode(JsonStatus.self, from: Data(contentsOf: url!))
        let dataInfo = JSON
        let stationsStatus = dataInfo.data

        //print(stations![0])
//        var arrayStations: [StationStatus] = []
//
//        guard let s = arrayStations else {
//            return
//        }
//        for station in  s {
//            arrayStations.append(station)
//            print("\(station.name) - \(station.address)  - \(station.rental_methods)")
//
//        }
//        print(arrayStations[0].name)
//        //    let data = info["data"]
    }
}
