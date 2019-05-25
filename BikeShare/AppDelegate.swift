//
//  AppDelegate.swift
//  BikeShare
//
//  Created by Russell Weber on 2019-05-22.
//  Copyright © 2019 Russell Weber. All rights reserved.
//

import UIKit
import MapKit

var realmQueue = DispatchQueue(label: "com.Weblay.BikeShare.realm")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
       var dao = StationDao.sharedInstance
    var stations : [Station] = []

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let bounds = UIScreen.main.bounds
    self.window = UIWindow(frame: bounds)
    let mainController = MainMenuViewController()

    //Getting the stations


    if dao.isEmpty(){
        let manager : StationManager = StationManager()
        manager.fetchBikeStation(userLocation: CLLocationCoordinate2DMake(0, 0), searchTerm: nil) { (stations) in
            guard let stations = stations else {
                return
            }
            manager.fetchStationStatus(stations: stations, completion: { (completedStations) in
                if let stations = completedStations {



                    DispatchQueue.main.async {
                        var stationsAnnotation: [StationAnnotation] = []
                        for station  in stations {
                            stationsAnnotation.append(StationAnnotation(station: station))
                        }
                        mainController.stations = stationsAnnotation

                        self.stations = stations
                        for station in stations {
                            self.dao.add(station: station )
                        }
                    }

//                    DispatchQueue.main.async {
//                        mainController.stations = stationsAnnotation
//
//                    }

                }
            })
        }
    } else {
        if let stations = dao.getAll(){
            var stationsAnnotation: [StationAnnotation] = []
            for station  in stations {
                stationsAnnotation.append(StationAnnotation(station: station))
            }
            mainController.stations = stationsAnnotation
        }

    }

    let navigationController = UINavigationController(rootViewController: mainController)
    navigationController.navigationBar.isTranslucent = false
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

