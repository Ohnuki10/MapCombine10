//
//  firebase3App.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI

@main
struct firebase3App: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var albumviewModel = AlbumViewModel()
    
    var body: some Scene {
        WindowGroup {
//            TestView()
            TabMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
    
 
    
}


//import CoreLocation
//
//class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var authorizationStatus: CLAuthorizationStatus
//    @Published var lastSeenLocation: CLLocation?
//
//    private let locationManager: CLLocationManager
//    
//    override init() {
//        locationManager = CLLocationManager()
//        authorizationStatus = locationManager.authorizationStatus
//        
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.allowsBackgroundLocationUpdates = true // バックグラウンド実行中も座標取得する場合、trueにする
//        locationManager.pausesLocationUpdatesAutomatically = false
//        locationManager.startUpdatingLocation()
//    }
//
//    func requestPermission() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization() // バックグラウンド実行中も座標取得する場合はこちら
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        authorizationStatus = manager.authorizationStatus
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastSeenLocation = locations.first
//    }
//}
