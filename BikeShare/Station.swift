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

@objcMembers public class Station: Object, MKAnnotation, Codable {
  public var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(lat, lon)
        }
    }
    public var title: String? {
        get {
            //TODO: Fix the title
//            let nameArray = name.split(separator: "/").first
//             guard  let firstName = nameArray?.first  else{
//                return nil
//            }
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
    @objc dynamic var rental_methods: [String] = []
    @objc dynamic var obcn: String = ""

    override public static func primaryKey() -> String? {
        return "station_id"
    }

}
