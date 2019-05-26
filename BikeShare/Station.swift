//
//  Station.swift
//  BikeShare
//
//  Created by Luiz on 5/22/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift

@objc public class Json: NSObject, Codable {
    var last_updated : Date
    var data: DataClass
}

@objcMembers public class DataClass: Codable {

  var stations : [Station]?
}

@objcMembers public class Station: Object, Codable, MKAnnotation {
  public var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(lat, lon)
        }
    }
    public var title: String? {
        get {

            return name
        }
        
    }
    public var subtitle: String?{
        get {
            return address
            }

}


    @objc dynamic var status : StationStatus?
    @objc dynamic var station_id : String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var address: String = ""
    @objc dynamic var capacity: Int = 0

//    private var rental_methods: [String] = []
    @objc dynamic var obcn: String = ""

    override public static func primaryKey() -> String? {
        return "station_id"
    }

    public class func convertAnnotationToStation(_ stationAnnotation: StationAnnotation) -> Station{
        let station = Station()
        if let address = stationAnnotation.subtitle {
            station.address = address
        }
        if let name = stationAnnotation.title {
            station.name = name
        }
        if let status = stationAnnotation.status {
            station.status = status
        }

        station.lat = stationAnnotation.coordinate.latitude
        station.lon =  stationAnnotation.coordinate.longitude
        station.station_id = stationAnnotation.station_id
        station.capacity = stationAnnotation.capacity
        return station
    }
}

public class RetalMethod: Object, Codable {
    @objc dynamic var rental: String?
}

//MARK: Handle with List
extension List : Decodable where Element : Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let element = try container.decode(Element.self)
            self.append(element)
        }
    }
}

extension List : Encodable where Element : Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for element in self {
            try element.encode(to: container.superEncoder())
        }
    }
}


//MARK: -Handle with Realm
public class StationAnnotation: NSObject, MKAnnotation {

    public var coordinate: CLLocationCoordinate2D

    public var title: String?
    public var subtitle: String?
    public var capacity: Int
    public var status : StationStatus?
    public var station_id : String = ""

    init(station: Station) {
        self.capacity = station.capacity
        self.status = station.status
        self.station_id = station.station_id
        self.coordinate = CLLocationCoordinate2DMake(station.lat, station.lon)
        self.title = station.title
        self.subtitle = station.subtitle
        super.init()
    }
}






















//    public let rental_methods: List<RetalMethod>
//    {
//        set {
//            self.rental_methods = Array(newValue)
//            }
//        get {
//            let rm = List<String>()
//            for item  in self.rental_methods {
//                rm.append(item)
//            }
//
//            return rm
//        }
//    }
