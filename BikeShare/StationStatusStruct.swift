//
//  StationStatusStruct.swift
//  BikeShare
//
//  Created by Frank Chen on 2019-05-25.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation

struct stationStatusStruct : Decodable{
  let station_id: String
  let num_bikes_available : Int
  let num_docks_available : Int
}
