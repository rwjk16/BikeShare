//
//  BikeInfo.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation
import RealmSwift
// MARK: - Welcome

@objc public class JsonStatus: NSObject, Codable {
    public var lastUpdated : Int
    public var data: DataInfo?

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case data = "data"
    }

    public init(lastUpdated: Int,  data: DataInfo) {
        self.lastUpdated = lastUpdated
        self.data = data
    }
}

// MARK: - DataInfo
@objcMembers public class DataInfo: NSObject, Codable {
    public var stationStatus: [StationStatus]
    enum CodingKeys: String, CodingKey {
        case stationStatus = "stations"
    }

    public init(stationsStatus: [StationStatus]) {
        self.stationStatus = stationsStatus
    }
}

// MARK: - StationStatus
@objc public class StationStatus: Object, Codable {
    @objc dynamic public var stationID: String = ""
    @objc dynamic public var numBikesAvailable: Int = 0
    @objc dynamic public var numBikesDisabled: Int  = 0
    @objc dynamic public var numDocksAvailable: Int = 0
    @objc dynamic public var numDocksDisabled : Int = 0
    @objc dynamic public var isInstalled: Int = 0
    @objc dynamic public var isChargingStation: Bool
    @objc dynamic public var status: String

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case numBikesAvailable = "num_bikes_available"
        case numBikesDisabled = "num_bikes_disabled"
        case numDocksAvailable = "num_docks_available"
        case numDocksDisabled = "num_docks_disabled"
        case isInstalled = "is_installed"
        case isChargingStation = "is_charging_station"
        case status = "status"
    }

//
//    convenience public init(stationID: String,
//                numBikesAvailable: Int,
//                numBikesDisabled: Int,
//                numDocksAvailable: Int,
//                numDocksDisabled: Int,
//                isInstalled: Int,
//                isChargingStation: Bool,
//                status: String) {
//        self.stationID = stationID
//        self.numBikesAvailable = numBikesAvailable
//        self.numBikesDisabled = numBikesDisabled
//        self.numDocksAvailable = numDocksAvailable
//        self.numDocksDisabled = numDocksDisabled
//        self.isInstalled = isInstalled
//        self.isChargingStation = isChargingStation
//        self.status = status
//    }


}
