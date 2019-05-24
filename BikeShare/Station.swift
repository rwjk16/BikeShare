//
//  Station.swift
//  BikeShare
//
//  Created by Luiz on 5/22/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation
import MapKit




@objc public class Json: NSObject, Codable {
    var last_updated : Date
    var data: DataClass

}

@objcMembers public class DataClass: Codable {

  var stations : [Station]?
}

@objcMembers public class Station: NSObject, MKAnnotation, Codable {
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

    var status : StationStatus? 
    var station_id : String = ""
    var name: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    var address: String = ""
    var capacity: Int = 0
    var rental_methods: [String] = []
    var obcn: String = ""
}
