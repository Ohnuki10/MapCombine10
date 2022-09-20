//
//  MapView.swift
//  MyCombine4
//
//  Created by 大貫 伽奈 on 2022/09/18.
//

import SwiftUI
import MapKit

//mapkitのviewをswiftuiのviewとして利用するため↓
struct MapView: UIViewRepresentable {
    
    //検索キーワード
    let searchKey:String
    let mapType: MKMapType
  
    
    
    //MAPを表示
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //入力された文字をデバックエリアに表示
        print(searchKey)
        uiView.mapType = mapType
        
        
        //座標とる
        let geocoder = CLGeocoder()
        
        
        geocoder.geocodeAddressString(
            searchKey ,
            
            completionHandler: { (placemarks,error)in
                
            if let unwrapPlacemarks = placemarks ,
               let firstPlacemark = unwrapPlacemarks.first ,
               let location = firstPlacemark.location {
                
                let targetCoordinate = location.coordinate
                print(targetCoordinate)
                
                let pin = MKPointAnnotation()
                pin.coordinate = targetCoordinate
                pin.title = searchKey
                uiView.addAnnotation(pin)
                uiView.region = MKCoordinateRegion(
                    center: targetCoordinate,
                    latitudinalMeters: 100000.0,
                    longitudinalMeters: 100000.0)

            }//location
                
            }//completionHandler
        )//geocodeAddressString
    }//updateuiview
}//UIViewRepresentable
    


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー",mapType: .standard)
    }
}
