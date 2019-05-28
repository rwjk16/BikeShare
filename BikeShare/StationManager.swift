//
//  station_manager.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation
import MapKit

class StationManager: NSObject {

  
  @objc func fetchBikeStation(userLocation location: CLLocationCoordinate2D, searchTerm: String? = nil, completion: @escaping ([MKAnnotation]?) -> ()) {
    
    guard let bikeStationURL =  URL(string: "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information") else {
      print("Error in the bikeStationURL")
      return
    }
    var request: URLRequest = URLRequest(url: bikeStationURL)
    request.httpMethod = "GET"
    
    let session: URLSession = URLSession.shared
    let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print("\(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        return
      }
      
      let statusCode: Int = httpResponse.statusCode
      
      if statusCode != 200 {
        print("Error: status code is equal to \(statusCode)")
        return
      }
      
      guard let data = data else {
        print("Error data is nil")
        return
      }
      
      do {
        let decoderJSON = JSONDecoder()
        let info = try decoderJSON.decode(Json.self, from: data)
        let data = info.data
        let stations = data.stations
        
        var arrayStations: [Station] = []
        
        guard let s = stations else {
          return
        }
        for station in  s {
          arrayStations.append(station)
          
        }
        
        for _ in arrayStations {
//          print(i.name)
        }
        DispatchQueue.main.async {
          completion(arrayStations)
        }
        
      }
      catch let err {
        print("Error is\(err)")
      }
    }
    task.resume()
  }
  
  func fetchPricePlan(completion: @escaping ([Plan]) -> ()) {
    struct DataResponse: Decodable
    {
      let data:PlanResponse
    }
    
    struct PlanResponse: Decodable{
      let plans:[Plan]
    }
    
    guard let bikePricePlan =  URL(string: "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_pricing_plans") else {return}
    
    var request: URLRequest = URLRequest(url: bikePricePlan)
    request.httpMethod = "GET"
    
    let session: URLSession = URLSession.shared
    let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print("\(error)")
        DispatchQueue.main.async {
          completion([])
        }
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        DispatchQueue.main.async {
          completion([])
        }
        return
      }
      
      let statusCode: Int = httpResponse.statusCode
      
      if statusCode != 200 {
        print("Error: status code is equal to \(statusCode)")
        DispatchQueue.main.async {
          completion([])
        }
        return
      }
      
      guard let data = data else {
        print("Error data is nil")
        DispatchQueue.main.async {
          completion([])
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let dataResponse = try decoder.decode(DataResponse.self, from: data)
        let plansResponse = dataResponse.data
        let plans = plansResponse.plans
        print(plans)

        DispatchQueue.main.async {
          completion(plans)
        }
        
      }
      catch let err {
        print("Error is\(err)")
      }
    }
    task.resume()
  }
}
