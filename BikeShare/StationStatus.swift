//
//  BikeInfo.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation

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
@objcMembers public class StationStatus:NSObject, Codable {
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

/*
 case stationID = "station_id"
 case numBikesAvailable = "num_bikes_available"
 case numBikesDisabled = "num_bikes_disabled"
 case numDocksAvailable = "num_docks_available"
 case numDocksDisabled = "num_docks_disabled"
 case isInstalled = "is_installed"
 case isChargingStation = "is_charging_station"
 case status = "status"
 */


}
//
//public extension StationStatus {
//    convenience init(data: Data) throws {
//        let value = try newJSONDecoder().decode(StationStatus.self, from: data)
//        self.init(stationID: value.stationID,
//                  numBikesAvailable: value.numBikesAvailable,
//                  numBikesDisabled: value.numBikesDisabled,
//                  numDocksAvailable: value.numDocksAvailable,
//                  numDocksDisabled: value.numDocksDisabled,
//                  isInstalled: value.isInstalled,
//                  isChargingStation: value.isChargingStation,
//                  status: value.status)
//    }
//
//    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    convenience init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
////    func with(
////        stationID: String? = nil,
////        numBikesAvailable: Int? = nil,
////        numBikesDisabled: Int? = nil,
////        numDocksAvailable: Int? = nil,
////        numDocksDisabled: Int? = nil,
////        isInstalled: Int? = nil,
////        isChargingStation: Bool? = nil,
////        status: String? = nil
////        ) -> Station {
////        return Station(
////            stationID: stationID ?? self.stationID,
////            numBikesAvailable: numBikesAvailable ?? self.numBikesAvailable,
////            numBikesDisabled: numBikesDisabled ?? self.numBikesDisabled,
////            numDocksAvailable: numDocksAvailable ?? self.numDocksAvailable,
////            numDocksDisabled: numDocksDisabled ?? self.numDocksDisabled,
////            isInstalled: isInstalled ?? self.isInstalled,
////            isChargingStation: isChargingStation ?? self.isChargingStation,
////            status: status ?? self.status
////        )
////    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
//public enum Status: String, Codable {
//    case endOfLife = "END_OF_LIFE"
//    case inService = "IN_SERVICE"
//    case planned = "PLANNED"
//}
//
//// MARK: - Helper functions for creating encoders and decoders
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
