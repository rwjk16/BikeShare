//
//  BikeInfo.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation

// MARK: - Welcome

 public class JsonStatus: Codable {
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
 public class DataInfo:  Codable {
    public var stationStatus: [StationStatus]
    enum CodingKeys: String, CodingKey {
        case stationStatus = "stations"
    }

    public init(stationsStatus: [StationStatus]) {
        self.stationStatus = stationsStatus
    }
}

// MARK: - StationStatus
 public class StationStatus: Codable {
    public var stationID: String = ""
    public var numBikesAvailable: Int = 0
    public var numBikesDisabled: Int  = 0
    public var numDocksAvailable: Int = 0
    public var numDocksDisabled : Int = 0
    public var isInstalled: Int = 0
    public var isChargingStation: Bool
    public var status: String

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

    public init(stationID: String,
                numBikesAvailable: Int,
                numBikesDisabled: Int,
                numDocksAvailable: Int,
                numDocksDisabled: Int,
                isInstalled: Int,
                isChargingStation: Bool,
                status: String) {
        self.stationID = stationID
        self.numBikesAvailable = numBikesAvailable
        self.numBikesDisabled = numBikesDisabled
        self.numDocksAvailable = numDocksAvailable
        self.numDocksDisabled = numDocksDisabled
        self.isInstalled = isInstalled
        self.isChargingStation = isChargingStation
        self.status = status
    }
}
