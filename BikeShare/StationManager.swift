//
//  station_manager.swift
//  BikeShare
//
//  Created by Luiz on 5/23/19.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import Foundation
import MapKit
import Realm
class StationManager: {


  func fetchBikeStation(userLocation location: CLLocationCoordinate2D, searchTerm: String?, completion: @escaping ([MKAnnotation]?) -> ()) {

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


    func fetchStationStatus( stations:  [Station] , completion: @escaping ([Station]?) -> ()) {

        guard let stationStatusURL =  URL(string: "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status") else {
            print("Error in the stationStatusURL - \(self)  - \(#function)")
            return
        }
        var request: URLRequest = URLRequest(url: stationStatusURL)
        request.httpMethod = "GET"

        //create a dictionary to search a station by id
        var dicOfStations: Dictionary<String, Station> = Dictionary<String,Station> ()
        for station  in stations {
            dicOfStations[station.station_id] = station
        }

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
                print("Error data is nil \(self) -  \(#function)")
                return
            }

            do {


                let decoderJSON = JSONDecoder()
                let info = try decoderJSON.decode(JsonStatus.self, from: data)
                let dataInfo = info.data


                guard let stationStatusArray: [StationStatus] = dataInfo?.stationStatus else {
                    return
                }
                var newStations = [Station]()
                for status in stationStatusArray {
                    if let station: Station = dicOfStations[status.stationID]  {

                        station.status = status
                        newStations.append(station)

                    } else {
                        print("erro in unwrapping station -statioid: \(status.stationID) - class: \(self) - function: \(#function)")
                    }

                }
                DispatchQueue.main.async {
                    completion(newStations)
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
