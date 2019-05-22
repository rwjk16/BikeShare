//
//  Station.swift
//  BikeShare
//
//  Created by Luiz on 5/22/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation


@objcMembers public class Json: Codable {

        var last_updated : Date

        var data: DataClass
    
}

@objcMembers public class DataClass: Codable {
    var stations : [Station]?
}

//@objc enum RentalMethod: String, Codable {
//    case creditcard = "CREDITCARD"
//    case key = "KEY"
//    case phone = "PHONE"
//    case transitcard = "TRANSITCARD"
//}

@objcMembers public class Station: Codable {
    var station_id : String = ""
    var name: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    var address: String = ""
    var capacity: Int = 0
    var rental_methods: [String] = []
    var obcn: String = ""
    

}
