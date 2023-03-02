//
//  Map2View.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import MapKit


struct Map2View: View {
    @ObservedObject var albumViewModel : AlbumViewModel


    @StateObject var conversionSpot = ConversionSpot()

    
    
    @State  var region = MKCoordinateRegion(
        center : CLLocationCoordinate2D(
            latitude: 35.710057714926265,  // 緯度
            longitude: 139.81071829999996 // 経度
        ),
        latitudinalMeters: 1000.0, // 南北
        longitudinalMeters: 1000.0 // 東西
    )
    
    let place = [IdentifiablePlace(lat: 37.334900, long: -122.009020),
                 IdentifiablePlace(lat: 37.33089, long: -122.00746)]
    
    var body: some View {
        Map(coordinateRegion: $region,
            
            showsUserLocation: true,
            annotationItems: place) { place in
              MapAnnotation(coordinate: place.location) {
                  Image(systemName: "tortoise.fill")
                      .foregroundColor(Color(UIColor.systemBackground))
                      .padding()
                      .background(Color.orange.cornerRadius(10))
              }
            
          }
        .task(){
                //位置情報へのアクセスを要求
                let manager = CLLocationManager()
                manager.requestWhenInUseAuthorization()
            }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
