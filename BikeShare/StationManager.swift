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


    @objc func fetchBikeStation(userLocation location: CLLocationCoordinate2D, searchTerm: String?, completion: @escaping ([MKAnnotation]?) -> ()) {

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

                for i in arrayStations {
                    print(i.name)
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

    @objc func fetchStationStatus( completion: @escaping ([StationStatus]?) -> ()) {

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

                for i in arrayStations {
                    print(i.name)
                }
                DispatchQueue.main.async {
//                    completion(StationStatus)
                }

            }
            catch let err {
                print("Error is\(err)")
            }
        }
        task.resume()
    }

}
