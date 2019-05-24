//
//  StationDao.swift
//  BikeShare
//
//  Created by Luiz on 5/24/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import RealmSwift


class StationDao: NSObject {
    private var database: Realm
    static let sharedInstance = StationDao()
    private override init() {
        database = try! Realm()
    }

    func add(station: Station){
        update(station: station)
    }

    func update(station: Station) {
        do {
            try database.write {
                database.add(station)
            }
        } catch  {
            print("\(error) - \(self) - \(#function)")
        }
    }

    func searchById(id: String) -> Station?{
        let stationObjcs =  database.objects(Station.self)
        let filteredStation = stationObjcs.filter(NSPredicate.init(format: "station_id = %@", id))
        if let station = filteredStation.first {
            return station
        }
        return nil
    }

    func getAll() -> [Station]? {
        let stationObjcs: Results =  database.objects(Station.self)
        var stations : [Station] = [Station]()
        for station in stationObjcs {
            stations.append(station)
        }
        return stations;
    }

    func isEmpty() -> Bool {
        return database.isEmpty
    }
}
